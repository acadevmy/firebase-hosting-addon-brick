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

  if (applications.isEmpty) {
    context.logger.alert("No applications found 😔");
    return;
  }

  List<Application> selectedApplications = context.logger.chooseAny(
    "Which applications do you want to set up as hosting? (Press Space for select an option)",
    choices: applications,
    display: (application) => application.displayName,
  );

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
  const angularDescriptor = 'angular.json';

  return File.fromUri(directory.uri.resolve(angularDescriptor)).existsSync();
}

bool checkIfIsCypressApplication(Directory directory) {
  const cypressDescriptor = 'cypress.config.ts';

  return File.fromUri(directory.uri.resolve(cypressDescriptor)).existsSync();
}

bool checkIfIsFirebaseApplication(Directory directory) {
  const firebaseDescriptor = 'firebase.json';

  return File.fromUri(directory.uri.resolve(firebaseDescriptor)).existsSync();
}

bool checkIfIsNestApplication(Directory directory) {
  const nestDescriptor = 'nest-cli.json';

  return File.fromUri(directory.uri.resolve(nestDescriptor)).existsSync();
}

bool checkIfIsNextApplication(Directory directory) {
  const nextDescriptor = 'next.config.mjs';
  // Cercare il file next.config anche con l'estensioni js, mjs, json

  return File.fromUri(directory.uri.resolve(nextDescriptor)).existsSync();
}

List<Application> getApplications(List<Directory> applicationsDirectories) {
  return applicationsDirectories
      .map((directory) => Application(directory: directory))
      .where((application) => application.type != ApplicationType.firebase)
      .toList();
}

ApplicationType getApplicationTypeFromDirectory(Directory directory) {
  if (checkIfIsAngularApplication(directory)) {
    return ApplicationType.angular;
  }

  if (checkIfIsCypressApplication(directory)) {
    return ApplicationType.cypress;
  }

  if (checkIfIsFirebaseApplication(directory)) {
    return ApplicationType.firebase;
  }

  if (checkIfIsNestApplication(directory)) {
    return ApplicationType.nest;
  }

  if (checkIfIsNextApplication(directory)) {
    return ApplicationType.next;
  }

  return ApplicationType.unknown;
}

class Application {
  Directory directory;
  ApplicationType type;

  String get name =>
      directory.uri.pathSegments.lastWhere((path) => path.isNotEmpty);
  String get displayName => '$name (${type.name.pascalCase})';

  Application({required this.directory})
      : type = getApplicationTypeFromDirectory(directory);
}

enum ApplicationType { angular, cypress, firebase, nest, next, unknown }
