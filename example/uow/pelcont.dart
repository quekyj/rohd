// FSM Heart

import 'package:rohd/rohd.dart';

enum TrafficState { s0, s1, s2, s3, s4, s5, s6 }

class Pelcont extends Module {
  Logic get red => output('red');
  Logic get amber => output('amber');
  Logic get green => output('green');
  Logic get entimer => output('entimer');

  Pelcont(Logic clock, Logic reset, Logic pedestrian, Logic short, Logic med,
      Logic long, Logic flash)
      : super(name: 'pelcont_fsm') {
    clock = addInput('clock', clock);
    reset = addInput(reset.name, reset);
    pedestrian = addInput(pedestrian.name, pedestrian);
    short = addInput(short.name, short);
    med = addInput(med.name, med);
    long = addInput(long.name, long);
    flash = addInput(flash.name, flash);

    final red = addOutput('red');
    final amber = addOutput('amber');
    final green = addOutput('green');
    final entimer = addOutput('entimer');

    final states = [
      State<TrafficState>(TrafficState.s0, events: {
        Const(1): TrafficState.s1
      }, actions: [
        // active low
        red < 0,
        amber < 1,
        green < 1,

        // active high
        entimer < 0
      ]),
      State<TrafficState>(TrafficState.s1, events: {
        long: TrafficState.s2,
        ~long: TrafficState.s1
      }, actions: [
        // active low
        red < 0,
        amber < 1,
        green < 1,

        // active high
        entimer < 1
      ]),
      State<TrafficState>(TrafficState.s2, events: {
        Const(1): TrafficState.s3
      }, actions: [
        // active low
        red < 1,
        amber < 0,
        green < 1,

        // active high
        entimer < 0
      ]),
      State<TrafficState>(TrafficState.s3, events: {
        med: TrafficState.s5,
        ~med & flash: TrafficState.s4,
        ~med & ~flash: TrafficState.s3
      }, actions: [
        // active low
        red < 1,
        amber < 0,
        green < 1,

        // active high
        entimer < 1
      ]),
      State<TrafficState>(TrafficState.s4, events: {
        med: TrafficState.s5,
        ~med & flash: TrafficState.s3,
        ~med & ~flash: TrafficState.s4
      }, actions: [
        // active low
        red < 1,
        amber < 1,
        green < 1,

        // active high
        entimer < 1
      ]),
      State<TrafficState>(TrafficState.s5, events: {
        pedestrian: TrafficState.s6,
        ~pedestrian: TrafficState.s5,
      }, actions: [
        // active low
        red < 1,
        amber < 1,
        green < 0,

        // active high
        entimer < 0
      ]),
      State<TrafficState>(TrafficState.s6, events: {
        short: TrafficState.s0,
        ~short: TrafficState.s6,
      }, actions: [
        // active low
        red < 1,
        amber < 0,
        green < 1,

        // active high
        entimer < 1
      ])
    ];

    StateMachine<TrafficState>(clock, reset, TrafficState.s0, states);
  }
}

Future<void> main() async {
  final clk = SimpleClockGenerator(10).clk;
  final reset = Logic(name: 'reset');
  final pedestrian = Logic(name: 'pedestrian');
  final short = Logic(name: 'short');
  final med = Logic(name: 'med');
  final long = Logic(name: 'long');
  final flash = Logic(name: 'flash');

  final mod = Pelcont(clk, reset, pedestrian, short, med, long, flash);

  await mod.build();
  print(mod.generateSynth());

  reset.inject(1);
  pedestrian.inject(0);
  short.inject(0);
  med.inject(0);
  long.inject(0);
  flash.inject(0);

  WaveDumper(mod, outputPath: 'pelcont.vcd');

  mod.red.changed.listen((event) {
    final redValue = event.newValue.toInt();

    print('@t=${Simulator.time}, red value change to: $redValue');
  });

  mod.amber.changed.listen((event) {
    final amberValue = event.newValue.toInt();

    print('@t=${Simulator.time}, amber value change to: $amberValue');
  });

  mod.green.changed.listen((event) {
    final greenValue = event.newValue.toInt();

    print('@t=${Simulator.time}, green value change to: $greenValue');
  });

  mod.entimer.changed.listen((event) {
    final entimerValue = event.newValue.toInt();

    print('@t=${Simulator.time}, entimer value change to: $entimerValue');
  });

  // At time 10, put down reset to go to state 1
  // next positive edge 15, entimer should show 1
  Simulator.registerAction(10, () => reset.put(10));

  // We want to go to state 2 -> 3
  Simulator.registerAction(15, () => long.put(1));

  Simulator.registerAction(20, () {
    flash.put(1);
    // med.put(0);
  });

  Simulator.registerAction(30, () {
    med.put(1);
  });

  Simulator.registerAction(40, () => pedestrian.put(1));

  Simulator.registerAction(50, () => short.put(1));

  Simulator.registerAction(70, () => pedestrian.put(0));

  // Print a message when we're done with the simulation!
  Simulator.registerAction(1000, () {
    print('Simulation completed!');
  });

  // Set a maximum time for the simulation so it doesn't keep running forever.
  Simulator.setMaxSimTime(1000);

  // Kick off the simulation.
  await Simulator.run();
}
