import 'dart:io';

import 'package:mason/mason.dart';

/**
 * Aggiungere Glob
 */

void run(HookContext context) {
  final workSpaceDirectory = getWorkSpaceDirectory();

  List<Directory> applicationsDirectories =
      getApplicationsDirectory(workSpaceDirectory);

  List<Application> applications = getApplications(applicationsDirectories);

  List<Application> selectedApplications = context.logger.chooseAny(
    "Which applications do you want to set up as hosting?",
    choices: applications,
    display: (application) => application.displayName,
  );

  print(selectedApplications);

  // Individuare il tipo per ogni application fe
  // Angular -> angular.json
  // Next -> next.config.mjs

  // Chiedere all'utente quale application aggiungere come hosting

  // Configurare l'array hosting del file firebase.json in base al tipo di application
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

bool checkIfIsAngularApplication(Directory directory) {
  const _angularDescriptor = 'angular.json';

  return File.fromUri(directory.uri.resolve(_angularDescriptor)).existsSync();
}

bool checkIfIsNextApplication(Directory directory) {
  const _nextDescriptor = 'next.config.mjs';
  // Cercare il file next.config anche con l'estensioni js, mjs, json

  return File.fromUri(directory.uri.resolve(_nextDescriptor)).existsSync();
}

List<Application> getApplications(List<Directory> applicationsDirectories) {
  return applicationsDirectories.map((directory) {
    ApplicationType type = ApplicationType.unknown;

    if (checkIfIsAngularApplication(directory)) {
      type = ApplicationType.angular;
    }

    if (checkIfIsNextApplication(directory)) {
      type = ApplicationType.next;
    }

    return Application(directory: directory, type: type);
  }).toList();
}

class Application {
  Directory directory;
  ApplicationType type;

  String get name => directory.uri.pathSegments.last;
  String get displayName => '$name (${type.name.pascalCase})';

  Application({required this.directory, required this.type});
}

enum ApplicationType { angular, next, unknown }
