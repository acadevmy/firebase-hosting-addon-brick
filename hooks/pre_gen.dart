import 'dart:convert';
import 'dart:io';
import 'package:mason/mason.dart';
import 'models/models.dart';

void run(HookContext context) async {
  final firebaseJsonUri = Directory.current.uri.resolve('firebase.json');

  final workSpaceDirectory = getWorkSpaceDirectory();

  List<Directory> applicationsDirectories =
      getApplicationsDirectory(workSpaceDirectory);

  List<Application> supportedApplications =
      getApplications(applicationsDirectories)
          .where(isSupportedApplication)
          .toList();

  if (supportedApplications.isEmpty) {
    context.logger.alert("No applications found 😔");
    return;
  }

  List<Application> selectedApplications = context.logger.chooseAny(
    "Which applications do you want to set up as hosting? (Press Space for select an option)",
    choices: supportedApplications,
    display: (application) => application.displayName,
  );

  List<Hosting> hostings = await getHostings(firebaseJsonUri);

  List<Hosting> hostingsToAdds = selectedApplications.map((application) {
    switch (application.type) {
      case ApplicationType.angular:
        return getAngularHosting(application);
      case ApplicationType.nest:
        return getNestHosting(application);
      case ApplicationType.next:
        return getNextHosting(application);
      default:
        throw Exception("ApplicationType is not supported");
    }
  }).toList();

  mergeHostings(
    context: context,
    hostings: hostings,
    hostingsToAdds: hostingsToAdds,
  );

  await setHostings(
    hostings: hostings,
    firebaseJsonUri: firebaseJsonUri,
  );

  await setFirebaserc(selectedApplications);
}

Directory getWorkSpaceDirectory() {
  Directory cursor = Directory.current;
  const _workspaceDescriptor = 'pnpm-workspace.yaml';

  while (!File.fromUri(cursor.uri.resolve(_workspaceDescriptor)).existsSync()) {
    if (cursor.path == cursor.parent.path) {
      throw Exception(
        'the command is not executed within a devmy project. Maybe you should get a coffee break ☕️',
      );
    }
    cursor = cursor.parent;
  }
  return cursor;
}

List<Directory> getApplicationsDirectory(Directory workspaceDirectory) {
  const kApplicationBasePath = 'applications';

  return Directory.fromUri(workspaceDirectory.uri.resolve(kApplicationBasePath))
      .listSync()
      .whereType<Directory>()
      .toList();
}

List<Application> getApplications(List<Directory> applicationsDirectories) {
  return applicationsDirectories
      .map((directory) => Application(directory: directory))
      .toList();
}

Future<List<Hosting>> getHostings(Uri firebaseJsonUri) async {
  final firebaseRawJson = await File.fromUri(firebaseJsonUri).readAsString();
  final rawHosting = json.decode(firebaseRawJson)['hosting'];

  if (rawHosting == null) {
    return [];
  }

  if (rawHosting is Map<String, dynamic>) {
    return [Hosting.fromJson(rawHosting)];
  }

  return (rawHosting as List<dynamic>)
      .map((hosting) => Hosting.fromJson(hosting))
      .toList();
}

void mergeHostings({
  required HookContext context,
  required List<Hosting> hostings,
  required List<Hosting> hostingsToAdds,
}) {
  hostingsToAdds.forEach((hostingToAdd) {
    final existingHostingIndex = hostings.indexWhere(
      (hosting) => hosting.target == hostingToAdd.target,
    );
    final notExists = existingHostingIndex == -1;

    if (notExists) {
      hostings.add(hostingToAdd);
      return;
    }

    final shouldOverwrite = context.logger.confirm(
      "The target ${hostingToAdd.target} is already present, do you want to overwrite it?",
    );

    if (!shouldOverwrite) {
      return;
    }

    hostings[existingHostingIndex] = hostingToAdd;
  });
}

Future<void> setHostings({
  required Uri firebaseJsonUri,
  required List<Hosting> hostings,
}) async {
  final firebaseRawJson = await File.fromUri(firebaseJsonUri).readAsString();
  final firebase = json.decode(firebaseRawJson);

  firebase['hosting'] = hostings.map((hosting) => hosting.toJson()).toList();

  final encoder = JsonEncoder.withIndent('  ');

  await File.fromUri(firebaseJsonUri).writeAsString(
    encoder.convert(firebase),
  );
}

Hosting getAngularHosting(Application application) {
  return Hosting(
    public: '../${application.name}/dist/browser',
    ignore: const ["**/.*", "**/node_modules/**"],
    rewrites: [Rewrite(source: '**', destination: "/index.html")],
    target: application.name,
  );
}

Hosting getNestHosting(Application application) {
  return Hosting(
    source: '../${application.name}',
    ignore: const ["**/.*", "**/node_modules/**"],
    target: application.name,
    frameworksBackend: FrameworksBackend(region: 'europe-west1'),
  );
}

Hosting getNextHosting(Application application) {
  return Hosting(
      source: '../${application.name}',
      ignore: const ["**/.*", "**/node_modules/**"],
      target: application.name,
      frameworksBackend: FrameworksBackend(region: 'europe-west1'));
}

Future<void> setFirebaserc(List<Application> applications) async {
  final firebaseRcUri = Directory.current.uri.resolve('.firebaserc');
  final firebaseRcRawJson = await File.fromUri(firebaseRcUri).readAsString();
  final rawProjects = json.decode(firebaseRcRawJson)['projects'];
  final rawTargets = json.decode(firebaseRcRawJson)['targets'];

  if (rawProjects == null) {
    return;
  }

  List<String> envinroments = List<String>.from(rawProjects.values)
      .toSet()
      .where((value) => value.isNotEmpty)
      .toList();

  Map<String, dynamic> targets = rawTargets ?? {};

  for (var envinroment in envinroments) {
    Map<String, dynamic> hostingMap =
        rawTargets?[envinroment]?['hosting'] ?? {};

    for (var application in applications) {
      hostingMap[application.name] = ['../${application.name}'];
    }

    targets[envinroment] = {"hosting": hostingMap};
  }

  Map<String, dynamic> finalJson = {
    "projects": rawProjects,
    "targets": targets
  };

  final encoder = JsonEncoder.withIndent('  ');

  await File.fromUri(firebaseRcUri).writeAsString(
    encoder.convert(finalJson),
  );
}

bool isSupportedApplication(Application application) {
  const supportedTypes = [
    ApplicationType.angular,
    ApplicationType.next,
  ];

  return supportedTypes.contains(application.type);
}
