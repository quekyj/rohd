class Data {
  late int time;
  late int value;
}

class Signal {
  late String name;
  late String type;
  late List<Data> data;
}

class Module {
  late String name;
  late List<Module> subModules;
  late List<Signal> signals;
}

class MetaData {
  late String source;
  late String timescale;
  late String date;
}

class WaveformNode {
  late MetaData metadata;
  late List<Module> modules;
}
