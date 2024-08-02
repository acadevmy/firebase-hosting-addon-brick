import 'dart:io';
import 'package:mason/mason.dart';
import 'application_types.model.dart';
import 'package:glob/glob.dart';

class Application {
  Directory directory;
  ApplicationType type;

  String get name =>
      directory.uri.pathSegments.lastWhere((path) => path.isNotEmpty);
  String get displayName => '$name (${type.name.pascalCase})';

  Application({required this.directory})
      : type = getApplicationTypeFromDirectory(directory);
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
  final nextDescriptor = Glob("^next\.config\.\w+\$").toString();
  return File.fromUri(directory.uri.resolve(nextDescriptor)).existsSync();
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
