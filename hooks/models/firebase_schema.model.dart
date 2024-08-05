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
