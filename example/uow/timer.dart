import 'package:rohd/rohd.dart';

class Timer extends Module {
  Timer(Logic start, Logic clk) : super(name: 'timer') {
    start = addInput('start', start);
    clk = addInput('clk', clk);

    final st = addOutput('st');
    final mt = addOutput('mt');
    final lt = addOutput('lt');

    // time delay values for light sequence
    // in tenths of a second
    final sTime = Logic(name: 'sTime', width: 8);
    final mTime = Const(80, width: 8);
    final lTime = Const(200, width: 8);

    sTime <= Const(50, width: 8);

    final q = Logic(name: 'q', width: 8);

    Sequential(clk, [
      IfBlock([
        Iff(~start | q.eq(lTime), [
          q < 0,
        ]),
        Else([
          q < q + 1,
        ])
      ]),
    ]);

    st <= q.eq(sTime);
    mt <= q.eq(mTime);
    lt <= q.eq(lTime);
  }
}

Future<void> main() async {
  final start = Logic(name: 'timer');
  final clk = SimpleClockGenerator(10).clk;

  final mod = Timer(start, clk);
  await mod.build();

  print(mod.generateSynth());

  start.inject(0);
  WaveDumper(mod, outputPath: 'uow_timer.vcd');

  // Drop reset at time 25.
  Simulator.registerAction(25, () => start.put(1));

  // Print a message when we're done with the simulation!
  Simulator.registerAction(5000, () {
    print('Simulation completed!');
  });

  Simulator.setMaxSimTime(5000);

  await Simulator.run();
}
