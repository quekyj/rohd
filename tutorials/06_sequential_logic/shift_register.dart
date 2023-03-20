// ignore_for_file: avoid_print

import 'dart:async';

import 'package:rohd/rohd.dart';

class ShiftRegister extends Module {
  ShiftRegister(Logic clk, Logic reset, Logic sin,
      {super.name = 'shift_register'}) {
    clk = addInput('clk', clk);
    reset = addInput('reset', reset);
    sin = addInput('s_in', sin, width: sin.width);

    const width = 4;

    final sout = addOutput('s_out', width: width);

    // A local signal
    final data = Logic(name: 'data', width: width); // 0000

    Sequential(clk, [
      IfBlock([
        Iff(reset, [
          data < 0,
        ]),
        Else([
          data < [data.slice(2, 0), sin].swizzle(), // left shift
        ]),
      ]),
    ]);

    sout <= data;
  }
  Logic get sout => output('s_out');
}

void main() async {
  final reset = Logic(name: 'reset');
  final clk = SimpleClockGenerator(10).clk;

  // value to shift in on positive clock edge triggered
  // let say '101'
  final sin = Logic(name: 's_in');

  final shiftReg = ShiftRegister(clk, reset, sin);
  await shiftReg.build();

  print(shiftReg.generateSynth());

  reset.inject(1);
  sin.inject(1);

  Simulator.registerAction(25, () {
    reset.put(0);
  });

  // listen to the shift in value
  shiftReg.sout.changed.listen((event) {
    print('Simulator time: ${Simulator.time}, current register '
        'value: ${event.newValue.toInt()}');
  });

  // Print a message when we're done with the simulation!
  Simulator.registerAction(100, () {
    print('Simulation completed!');
  });

  // Set a maximum time for the simulation so it doesn't keep running forever.
  Simulator.setMaxSimTime(100);

  WaveDumper(shiftReg,
      outputPath: 'tutorials/06_sequential_logic/shiftReg.vcd');

  // Kick off the simulation.
  await Simulator.run();
}
