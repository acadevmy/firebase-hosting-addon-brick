import 'dart:convert';
import 'dart:io';
import 'package:mason/mason.dart';
import 'models/models.dart';

/**
 * Aggiungere Glob
 */

void run(HookContext context) async {
  final firebaseJsonUri = Directory.current.uri.resolve('firebase.json');

  final workSpaceDirectory = getWorkSpaceDirectory();

  List<Directory> applicationsDirectories =
      getApplicationsDirectory(workSpaceDirectory);

  List<Application> applications = getApplications(applicationsDirectories)
      .where(isSupportedApplication)
      .toList();

  if (applications.isEmpty) {
    context.logger.alert("No applications found 😔");
    return;
  }

  List<Application> selectedApplications = context.logger.chooseAny(
    "Which applications do you want to set up as hosting? (Press Space for select an option)",
    choices: applications,
    display: (application) => application.displayName,
  );

  FirebaseConfig firebaseConfig = await getFirebaseConfig(firebaseJsonUri);

  List<Hosting> hostings = selectedApplications.map((application) {
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

  firebaseConfig.hosting.addAll(hostings);

  await setFirebaseConfig(
    firebaseJsonUri: firebaseJsonUri,
    firebaseConfig: firebaseConfig,
  );
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

Future<FirebaseConfig> getFirebaseConfig(Uri firebaseJsonUri) async {
  final firebaseRawJson = await File.fromUri(firebaseJsonUri).readAsString();
  return FirebaseConfig.fromJson(json.decode(firebaseRawJson));
}

Future<void> setFirebaseConfig({
  required Uri firebaseJsonUri,
  required FirebaseConfig firebaseConfig,
}) async {
  await File.fromUri(firebaseJsonUri).writeAsString(
    json.encode(firebaseConfig.toJson()),
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
    ignore: const ["firebase.json", "**/.*", "**/node_modules/**"],
    target: application.name,
    frameworksBackend: FrameworksBackend(region: 'europe-west1'),
  );
}

bool isSupportedApplication(Application application) {
  const supportedTypes = [
    ApplicationType.angular,
    ApplicationType.nest,
    ApplicationType.next,
  ];

  return supportedTypes.contains(application.type);
}
