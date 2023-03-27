import 'package:rohd/rohd.dart';

class FRTimer extends Module {
  Logic get fr => output('fr');
  FRTimer(Logic clk, Logic reset) : super(name: 'timer_fr') {
    reset = addInput('reset', reset);
    clk = addInput('clk', clk);
    final fr = addOutput('fr');

    // local signals
    final frtime = Logic(name: 'fr_time', width: 3);
    frtime <= Const(5, width: 3);

    final q = Logic(name: 'q', width: 3);

    Sequential(clk, [
      IfBlock([
        Iff(reset | q.eq(frtime), [
          q < 0,
        ]),
        Else([
          q < q + 1,
        ])
      ]),
    ]);

    fr <= q.eq(frtime);
  }
}

Future<void> main() async {
  final clk = SimpleClockGenerator(10).clk;
  final reset = Logic(name: 'reset');

  final mod = FRTimer(clk, reset);
  await mod.build();

  print(mod.generateSynth());

  reset.put(1);
  WaveDumper(mod, outputPath: 'uow_timer_fr.vcd');

  // Drop reset at time 5.
  Simulator.registerAction(10, () => reset.put(0));

  // Print a message when we're done with the simulation!
  Simulator.registerAction(100, () {
    print('Simulation completed!');
  });

  Simulator.setMaxSimTime(100);

  await Simulator.run();
}
