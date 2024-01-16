class Data {
  int time;
  int value;

  Data({required this.time, required this.value});

  Map<String, dynamic> toJson() => {
        'time': time,
        'value': value,
      };

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      time: json['time'],
      value: json['value'],
    );
  }
}

class Signal {
  String name;
  String type;
  List<Data> data;

  Signal({required this.name, required this.type, required this.data});

  Map<String, dynamic> toJson() => {
        'name': name,
        'type': type,
        'data': data.map((e) => e.toJson()).toList(),
      };

  factory Signal.fromJson(Map<String, dynamic> json) {
    return Signal(
      name: json['name'],
      type: json['type'],
      data: (json['data'] as List).map((e) => Data.fromJson(e)).toList(),
    );
  }
}

class Module {
  String name;
  List<Module> subModules;
  List<Signal> signals;

  Module({required this.name, required this.subModules, required this.signals});

  Map<String, dynamic> toJson() => {
        'name': name,
        'subModules': subModules.map((e) => e.toJson()).toList(),
        'signals': signals.map((e) => e.toJson()).toList(),
      };

  factory Module.fromJson(Map<String, dynamic> json) {
    var subModulesJson = json['subModules'] as List;
    var signalsJson = json['signals'] as List;

    return Module(
      name: json['name'],
      subModules: subModulesJson.map((e) => Module.fromJson(e)).toList(),
      signals: signalsJson.map((e) => Signal.fromJson(e)).toList(),
    );
  }
}

class MetaData {
  String source;
  String timescale;
  String date;

  MetaData({required this.source, required this.timescale, required this.date});

  Map<String, dynamic> toJson() => {
        'source': source,
        'timescale': timescale,
        'date': date,
      };

  factory MetaData.fromJson(Map<String, dynamic> json) {
    return MetaData(
      source: json['source'],
      timescale: json['timescale'],
      date: json['date'],
    );
  }
}

class WaveformModel {
  MetaData metadata;
  List<Module> modules;

  WaveformModel({required this.metadata, required this.modules});

  Map<String, dynamic> toJson() => {
        'metadata': metadata.toJson(),
        'modules': modules.map((e) => e.toJson()).toList(),
      };

  factory WaveformModel.fromJson(Map<String, dynamic> json) {
    return WaveformModel(
      metadata: MetaData.fromJson(json['metadata']),
      modules:
          (json['modules'] as List).map((e) => Module.fromJson(e)).toList(),
    );
  }
}
