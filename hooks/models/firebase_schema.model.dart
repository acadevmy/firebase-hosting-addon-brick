class FirebaseConfig {
  final String schema;
  final Database? database;
  final DataConnect? dataconnect;
  final Emulators? emulators;
  final ExtensionsConfig? extensions;
  final Firestore? firestore;
  final Functions? functions;
  final List<Hosting> hosting;

  FirebaseConfig({
    required this.schema,
    this.database,
    this.dataconnect,
    this.emulators,
    this.extensions,
    this.firestore,
    this.functions,
    this.hosting = const [],
  });

  factory FirebaseConfig.fromJson(Map<String, dynamic> json) {
    final rawHosting = json['hosting'];

    return FirebaseConfig(
      schema: json['\$schema'],
      database:
          json['database'] != null ? Database.fromJson(json['database']) : null,
      dataconnect: json['dataconnect'] != null
          ? DataConnect.fromJson(json['dataconnect'])
          : null,
      emulators: json['emulators'] != null
          ? Emulators.fromJson(json['emulators'])
          : null,
      extensions: json['extensions'] != null
          ? ExtensionsConfig.fromJson(json['extensions'])
          : null,
      firestore: json['firestore'] != null
          ? Firestore.fromJson(json['firestore'])
          : null,
      functions: json['functions'] != null
          ? Functions.fromJson(json['functions'])
          : null,
      hosting: _coerceHosting(rawHosting),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '\$schema': schema,
      'database': database?.toJson(),
      'dataconnect': dataconnect?.toJson(),
      'emulators': emulators?.toJson(),
      'extensions': extensions?.toJson(),
      'firestore': firestore?.toJson(),
      'functions': functions?.toJson(),
      'hosting': hosting.map((host) => host.toJson()).toList(),
    };
  }

  static List<Hosting> _coerceHosting(dynamic rawHosting) {
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
}

class Database {
  final List<String>? postdeploy;
  final List<String>? predeploy;
  final String rules;
  final String? instance;
  final String? target;

  Database({
    this.postdeploy,
    this.predeploy,
    required this.rules,
    this.instance,
    this.target,
  });

  factory Database.fromJson(Map<String, dynamic> json) {
    return Database(
      postdeploy: json['postdeploy'] != null
          ? List<String>.from(json['postdeploy'])
          : null,
      predeploy: json['predeploy'] != null
          ? List<String>.from(json['predeploy'])
          : null,
      rules: json['rules'],
      instance: json['instance'],
      target: json['target'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'postdeploy': postdeploy,
      'predeploy': predeploy,
      'rules': rules,
      'instance': instance,
      'target': target,
    };
  }
}

class DataConnect {
  final List<String>? postdeploy;
  final List<String>? predeploy;
  final String source;

  DataConnect({
    this.postdeploy,
    this.predeploy,
    required this.source,
  });

  factory DataConnect.fromJson(Map<String, dynamic> json) {
    return DataConnect(
      postdeploy: json['postdeploy'] != null
          ? List<String>.from(json['postdeploy'])
          : null,
      predeploy: json['predeploy'] != null
          ? List<String>.from(json['predeploy'])
          : null,
      source: json['source'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'postdeploy': postdeploy,
      'predeploy': predeploy,
      'source': source,
    };
  }
}

class Emulators {
  final Emulator? auth;
  final Emulator? database;
  final Emulator? dataconnect;
  final Emulator? eventarc;
  final Emulator? firestore;
  final Emulator? functions;
  final Emulator? hosting;
  final Emulator? hub;
  final Emulator? logging;
  final Emulator? pubsub;
  final Emulator? storage;
  final EmulatorUI? ui;
  final bool? singleProjectMode;

  Emulators({
    this.auth,
    this.database,
    this.dataconnect,
    this.eventarc,
    this.firestore,
    this.functions,
    this.hosting,
    this.hub,
    this.logging,
    this.pubsub,
    this.storage,
    this.ui,
    this.singleProjectMode,
  });

  factory Emulators.fromJson(Map<String, dynamic> json) {
    return Emulators(
      auth: json['auth'] != null ? Emulator.fromJson(json['auth']) : null,
      database:
          json['database'] != null ? Emulator.fromJson(json['database']) : null,
      dataconnect: json['dataconnect'] != null
          ? Emulator.fromJson(json['dataconnect'])
          : null,
      eventarc:
          json['eventarc'] != null ? Emulator.fromJson(json['eventarc']) : null,
      firestore: json['firestore'] != null
          ? Emulator.fromJson(json['firestore'])
          : null,
      functions: json['functions'] != null
          ? Emulator.fromJson(json['functions'])
          : null,
      hosting:
          json['hosting'] != null ? Emulator.fromJson(json['hosting']) : null,
      hub: json['hub'] != null ? Emulator.fromJson(json['hub']) : null,
      logging:
          json['logging'] != null ? Emulator.fromJson(json['logging']) : null,
      pubsub: json['pubsub'] != null ? Emulator.fromJson(json['pubsub']) : null,
      storage:
          json['storage'] != null ? Emulator.fromJson(json['storage']) : null,
      ui: json['ui'] != null ? EmulatorUI.fromJson(json['ui']) : null,
      singleProjectMode: json['singleProjectMode'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'auth': auth?.toJson(),
      'database': database?.toJson(),
      'dataconnect': dataconnect?.toJson(),
      'eventarc': eventarc?.toJson(),
      'firestore': firestore?.toJson(),
      'functions': functions?.toJson(),
      'hosting': hosting?.toJson(),
      'hub': hub?.toJson(),
      'logging': logging?.toJson(),
      'pubsub': pubsub?.toJson(),
      'storage': storage?.toJson(),
      'ui': ui?.toJson(),
      'singleProjectMode': singleProjectMode,
    };
  }
}

class Emulator {
  final String? host;
  final int? port;

  Emulator({
    this.host,
    this.port,
  });

  factory Emulator.fromJson(Map<String, dynamic> json) {
    return Emulator(
      host: json['host'],
      port: json['port'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'host': host,
      'port': port,
    };
  }
}

class EmulatorUI {
  final bool? enabled;
  final String? host;
  final dynamic port;

  EmulatorUI({
    this.enabled,
    this.host,
    this.port,
  });

  factory EmulatorUI.fromJson(Map<String, dynamic> json) {
    return EmulatorUI(
      enabled: json['enabled'],
      host: json['host'],
      port: json['port'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'enabled': enabled,
      'host': host,
      'port': port,
    };
  }
}

class ExtensionsConfig {
  ExtensionsConfig();

  factory ExtensionsConfig.fromJson(Map<String, dynamic> json) {
    return ExtensionsConfig();
  }

  Map<String, dynamic> toJson() {
    return {};
  }
}

class Firestore {
  final String? database;
  final String? indexes;
  final List<String>? postdeploy;
  final List<String>? predeploy;
  final String rules;
  final String? target;

  Firestore({
    this.database,
    this.indexes,
    this.postdeploy,
    this.predeploy,
    required this.rules,
    this.target,
  });

  factory Firestore.fromJson(Map<String, dynamic> json) {
    return Firestore(
      database: json['database'],
      indexes: json['indexes'],
      postdeploy: json['postdeploy'] != null
          ? List<String>.from(json['postdeploy'])
          : null,
      predeploy: json['predeploy'] != null
          ? List<String>.from(json['predeploy'])
          : null,
      rules: json['rules'],
      target: json['target'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'database': database,
      'indexes': indexes,
      'postdeploy': postdeploy,
      'predeploy': predeploy,
      'rules': rules,
      'target': target,
    };
  }
}

class Functions {
  final String? codebase;
  final List<String>? ignore;
  final List<String>? postdeploy;
  final List<String>? predeploy;
  final String? runtime;
  final String? source;

  Functions({
    this.codebase,
    this.ignore,
    this.postdeploy,
    this.predeploy,
    this.runtime,
    this.source,
  });

  factory Functions.fromJson(Map<String, dynamic> json) {
    return Functions(
      codebase: json['codebase'],
      ignore: json['ignore'] != null ? List<String>.from(json['ignore']) : null,
      postdeploy: json['postdeploy'] != null
          ? List<String>.from(json['postdeploy'])
          : null,
      predeploy: json['predeploy'] != null
          ? List<String>.from(json['predeploy'])
          : null,
      runtime: json['runtime'],
      source: json['source'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'codebase': codebase,
      'ignore': ignore,
      'postdeploy': postdeploy,
      'predeploy': predeploy,
      'runtime': runtime,
      'source': source,
    };
  }
}

class Redirect {
  String? source;
  String? destination;
  String? glob;
  int? type;

  Redirect({this.source, this.destination, this.glob, this.type});

  Redirect.fromJson(Map<String, dynamic> json) {
    destination = json['destination'];
    glob = json['glob'];
    source = json['source'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['destination'] = this.destination;
    data['glob'] = this.glob;
    data['source'] = this.source;
    data['type'] = this.type;

    return Map.fromEntries(data.entries.where((entry) => entry.value != null));
  }
}

class I18n {
  String? root;

  I18n({this.root});

  I18n.fromJson(Map<String, dynamic> json) {
    root = json['root'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['root'] = this.root;
    return Map.fromEntries(data.entries.where((entry) => entry.value != null));
  }
}

class Hosting {
  String? target;
  FrameworksBackend? frameworksBackend;
  String? site;
  String? appAssociation;
  I18n? i18n;
  String? public;
  List<Redirect>? redirects;
  String? source;
  List<String>? ignore;
  List<Rewrite>? rewrites;

  Hosting({
    this.target,
    this.frameworksBackend,
    this.site,
    this.appAssociation,
    this.i18n,
    this.public,
    this.redirects,
    this.source,
    this.ignore,
    this.rewrites,
  });

  Hosting.fromJson(Map<String, dynamic> json) {
    target = json['target'];
    frameworksBackend = json['frameworksBackend'] != null
        ? new FrameworksBackend.fromJson(json['frameworksBackend'])
        : null;
    site = json['site'];
    appAssociation = json['appAssociation'];
    i18n = json['i18n'] != null ? new I18n.fromJson(json['i18n']) : null;
    public = json['public'];
    source = json['source'];

    if (json['redirects'] != null) {
      redirects = [];

      json['redirects'].forEach((v) {
        redirects!.add(Redirect.fromJson(v));
      });
    }

    if (json['ignore'] != null) {
      ignore = [];
      json['ignore'].forEach((v) {
        ignore!.add(v);
      });
    }

    if (json['rewrites'] != null) {
      rewrites = [];
      json['rewrites'].forEach((v) {
        rewrites!.add(Rewrite.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['target'] = this.target;
    if (this.frameworksBackend != null) {
      data['frameworksBackend'] = this.frameworksBackend!.toJson();
    }
    data['site'] = this.site;
    data['appAssociation'] = this.appAssociation;
    if (this.i18n != null) {
      data['i18n'] = this.i18n!.toJson();
    }
    data['public'] = this.public;
    if (this.redirects != null) {
      data['redirects'] = this.redirects!.map((v) => v.toJson()).toList();
    }
    data['source'] = this.source;
    data['ignore'] = this.ignore;
    data['rewrites'] = this.rewrites;

    return Map.fromEntries(data.entries.where((entry) => entry.value != null));
  }
}

class Rewrite {
  final String? destination;
  final String? glob;
  final String? function;
  final String? region;
  final FunctionDetails? functionDetails;
  final RunDetails? run;
  final bool? dynamicLinks;
  final String? source;
  final String? regex;

  Rewrite({
    this.destination,
    this.glob,
    this.function,
    this.region,
    this.functionDetails,
    this.run,
    this.dynamicLinks,
    this.source,
    this.regex,
  });

  factory Rewrite.fromJson(Map<String, dynamic> json) {
    return Rewrite(
      destination: json['destination'],
      glob: json['glob'],
      function: json['function'],
      region: json['region'],
      functionDetails: json['function'] is Map
          ? FunctionDetails.fromJson(json['function'])
          : null,
      run: json['run'] != null ? RunDetails.fromJson(json['run']) : null,
      dynamicLinks: json['dynamicLinks'],
      source: json['source'],
      regex: json['regex'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (destination != null) data['destination'] = destination;
    if (glob != null) data['glob'] = glob;
    if (function != null) data['function'] = function;
    if (region != null) data['region'] = region;
    if (functionDetails != null) data['function'] = functionDetails!.toJson();
    if (run != null) data['run'] = run!.toJson();
    if (dynamicLinks != null) data['dynamicLinks'] = dynamicLinks;
    if (source != null) data['source'] = source;
    if (regex != null) data['regex'] = regex;
    return data;
  }
}

class FunctionDetails {
  final String functionId;
  final bool? pinTag;
  final String? region;

  FunctionDetails({
    required this.functionId,
    this.pinTag,
    this.region,
  });

  factory FunctionDetails.fromJson(Map<String, dynamic> json) {
    return FunctionDetails(
      functionId: json['functionId'],
      pinTag: json['pinTag'],
      region: json['region'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {'functionId': functionId};
    if (pinTag != null) data['pinTag'] = pinTag;
    if (region != null) data['region'] = region;
    return data;
  }
}

class RunDetails {
  final String serviceId;
  final bool? pinTag;
  final String? region;

  RunDetails({
    required this.serviceId,
    this.pinTag,
    this.region,
  });

  factory RunDetails.fromJson(Map<String, dynamic> json) {
    return RunDetails(
      serviceId: json['serviceId'],
      pinTag: json['pinTag'],
      region: json['region'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {'serviceId': serviceId};
    if (pinTag != null) data['pinTag'] = pinTag;
    if (region != null) data['region'] = region;
    return data;
  }
}

class FrameworksBackend {
  double? concurrency;
  String? cors;
  String? cpu;
  bool? enforceAppCheck;
  String? ingressSettings;
  String? invoker;
  double? maxInstances;
  String? memory;
  double? minInstances;
  bool? omit;
  bool? preserveExternalChanges;
  String? region;
  List<String>? secrets;

  FrameworksBackend(
      {this.concurrency,
      this.cors,
      this.cpu,
      this.enforceAppCheck,
      this.ingressSettings,
      this.invoker,
      this.maxInstances,
      this.memory,
      this.minInstances,
      this.omit,
      this.preserveExternalChanges,
      this.region,
      this.secrets});

  FrameworksBackend.fromJson(Map<String, dynamic> json) {
    concurrency = json['concurrency'];
    cors = json['cors'];
    cpu = json['cpu'];
    enforceAppCheck = json['enforceAppCheck'];
    ingressSettings = json['ingressSettings'];
    invoker = json['invoker'];
    maxInstances = json['maxInstances'];
    memory = json['memory'];
    minInstances = json['minInstances'];
    omit = json['omit'];
    preserveExternalChanges = json['preserveExternalChanges'];
    region = json['region'];
    secrets = json['secrets'] != null ? json['secrets'] as List<String> : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['concurrency'] = this.concurrency;
    data['cors'] = this.cors;
    data['cpu'] = this.cpu;
    data['enforceAppCheck'] = this.enforceAppCheck;
    data['ingressSettings'] = this.ingressSettings;
    data['invoker'] = this.invoker;
    data['maxInstances'] = this.maxInstances;
    data['memory'] = this.memory;
    data['minInstances'] = this.minInstances;
    data['omit'] = this.omit;
    data['preserveExternalChanges'] = this.preserveExternalChanges;
    data['region'] = this.region;
    data['secrets'] = this.secrets;

    return Map.fromEntries(data.entries.where((entry) => entry.value != null));
  }
}

class Headers {
  final String? source;
  final List<Header>? headers;

  Headers({
    this.source,
    this.headers,
  });

  factory Headers.fromJson(Map<String, dynamic> json) {
    return Headers(
      source: json['source'],
      headers: json['headers'] != null
          ? List<Header>.from(json['headers'].map((x) => Header.fromJson(x)))
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'source': source,
      'headers': headers?.map((x) => x.toJson()).toList(),
    };
  }
}

class FrameworksBackendOptions {
  final int? concurrency;
  final String? cors;
  final String? cpu;
  final bool? enforceAppCheck;
  final String? ingressSettings;
  final List<String>? invoker;
  final Map<String, String>? labels;
  final int? maxInstances;
  final String? memory;
  final int? minInstances;
  final bool? omit;
  final bool? preserveExternalChanges;
  final List<String>? region;
  final List<String>? secrets;
  final String? serviceAccount;
  final int? timeoutSeconds;
  final String? vpcConnector;
  final String? vpcConnectorEgressSettings;

  FrameworksBackendOptions({
    this.concurrency,
    this.cors,
    this.cpu,
    this.enforceAppCheck,
    this.ingressSettings,
    this.invoker,
    this.labels,
    this.maxInstances,
    this.memory,
    this.minInstances,
    this.omit,
    this.preserveExternalChanges,
    this.region,
    this.secrets,
    this.serviceAccount,
    this.timeoutSeconds,
    this.vpcConnector,
    this.vpcConnectorEgressSettings,
  });

  factory FrameworksBackendOptions.fromJson(Map<String, dynamic> json) {
    return FrameworksBackendOptions(
      concurrency: json['concurrency'],
      cors: json['cors'],
      cpu: json['cpu'],
      enforceAppCheck: json['enforceAppCheck'],
      ingressSettings: json['ingressSettings'],
      invoker:
          json['invoker'] != null ? List<String>.from(json['invoker']) : null,
      labels: json['labels'] != null
          ? Map<String, String>.from(json['labels'])
          : null,
      maxInstances: json['maxInstances'],
      memory: json['memory'],
      minInstances: json['minInstances'],
      omit: json['omit'],
      preserveExternalChanges: json['preserveExternalChanges'],
      region: json['region'],
      secrets:
          json['secrets'] != null ? List<String>.from(json['secrets']) : null,
      serviceAccount: json['serviceAccount'],
      timeoutSeconds: json['timeoutSeconds'],
      vpcConnector: json['vpcConnector'],
      vpcConnectorEgressSettings: json['vpcConnectorEgressSettings'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'concurrency': concurrency,
      'cors': cors,
      'cpu': cpu,
      'enforceAppCheck': enforceAppCheck,
      'ingressSettings': ingressSettings,
      'invoker': invoker,
      'labels': labels,
      'maxInstances': maxInstances,
      'memory': memory,
      'minInstances': minInstances,
      'omit': omit,
      'preserveExternalChanges': preserveExternalChanges,
      'region': region,
      'secrets': secrets,
      'serviceAccount': serviceAccount,
      'timeoutSeconds': timeoutSeconds,
      'vpcConnector': vpcConnector,
      'vpcConnectorEgressSettings': vpcConnectorEgressSettings,
    };
  }
}

class Header {
  final String? source;
  final String? value;

  Header({
    this.source,
    this.value,
  });

  factory Header.fromJson(Map<String, dynamic> json) {
    return Header(
      source: json['source'],
      value: json['value'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'source': source,
      'value': value,
    };
  }
}
