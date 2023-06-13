import 'dart:io';
import 'package:rohd/rohd.dart';
import 'fr_timer.dart';
import 'pelcont.dart';
import 'timer.dart';

class Pelican extends Module {
  Pelican(Logic clk, Logic ped, Logic reset) : super(name: 'pelican') {
    clk = addInput('clk', clk);
    ped = addInput(ped.name, ped);
    reset = addInput(reset.name, reset);

    final red = addOutput('red');
    final amber = addOutput('amber');
    final green = addOutput('green');

    // wire
    final et = Logic(name: 'et_wire');
    final fl = Logic(name: 'fl_wire');
    final lt = Logic(name: 'lt_wire');
    final mt = Logic(name: 'mt_wire');
    final st = Logic(name: 'st_wire');

    // call Module
    final frTimer = FRTimer(clk, reset);
    final timer = Timer(et, clk);
    final pelcont = Pelcont(clk, reset, ped, st, mt, lt, fl);

    // assign
    et <= pelcont.entimer;
    fl <= frTimer.fr;
    lt <= timer.lt;
    mt <= timer.mt;
    st <= timer.st;

    red <= pelcont.red;
    amber <= pelcont.amber;
    green <= pelcont.green;
  }
}

Future<void> main() async {
  final clk = SimpleClockGenerator(10).clk;
  final ped = Logic(name: 'ped');
  final reset = Logic(name: 'reset');

  final pelican = Pelican(clk, ped, reset);
  await pelican.build();

  ped.inject(0);
  reset.inject(1);

  WaveDumper(pelican, outputPath: 'pelican.vcd');

  Simulator.registerAction(25, () => reset.put(0));
  Simulator.registerAction(25, () => ped.put(1));

  Simulator.registerAction(400, () {
    print(pelican);
  });

  final svPelican = pelican.generateSynth();
  File('example/uow/pelican.sv').writeAsStringSync(svPelican);

  Simulator.registerAction(500, () => ped.put(0));

  Simulator.registerAction(3000, () => print('Simulation Complete'));
  Simulator.setMaxSimTime(3000);
  await Simulator.run();
}
