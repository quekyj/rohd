class Data {
  int time;
  int value;

  Data({required this.time, required this.value});
}

class Signal {
  String name;
  String type;
  List<Data> data;

  Signal({required this.name, required this.type, required this.data});
}

class Module {
  String name;
  List<Module> subModules;
  List<Signal> signals;

  Module({required this.name, required this.subModules, required this.signals});
}

class MetaData {
  String source;
  String timescale;
  String date;

  MetaData({required this.source, required this.timescale, required this.date});
}

class WaveformNode {
  MetaData metadata;
  List<Module> modules;

  WaveformNode({required this.metadata, required this.modules});
}
