import 'package:rohd/rohd.dart';
import 'package:rohd_cosim/rohd_cosim.dart';

class ShiftRegister extends ExternalSystemVerilogModule with Cosim {
  Logic get sum => output('sum');
  Logic get cout => output('cout');

  @override
  List<String>? get verilogSources => ['../shift_register.sv'];

  ShiftRegister(Logic clk, Logic reset, Logic shiftIn, {super.name = 'shift_reg'})
      : super(definitionName: 'ShiftRegister') {
    clk = addInput('clk', clk);
    reset = addInput('reset', reset);
    shiftIn = addInput('shift_in', shiftIn);

    addOutput('shift_out', width: 8);
  }
}

Future<void> main({bool noPrint = false}) async {
  final clk = SimpleClockGenerator(10).clk;
  final reset = Logic(name: 'reset');
  final shiftIn = Logic(name: 'shift_in');

  final shiftReg = ShiftRegister(clk, reset, shiftIn);

  await shiftReg.build();

  await Cosim.connectCosimulation(CosimWrapConfig(
    SystemVerilogSimulator.icarus,
    directory: './doc/tutorials/chapter_9/answers/shift_tmp/',
  ));

  reset.inject(1);
  shiftIn.inject(0);

  WaveDumper(shiftReg, outputPath: './doc/tutorials/chapter_9/answers/shift_tmp/wave.vcd');

  Simulator.registerAction(25, () {
    reset.put(0);
    shiftIn.put(1);
  });

  Simulator.setMaxSimTime(100);
  await Simulator.run();
  
}
