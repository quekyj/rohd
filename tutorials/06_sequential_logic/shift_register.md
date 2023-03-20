# Sequential Logic (Shift Register)

From the previous section, you saw how a combinational logic is used in the ROHD module. Today, we are going to dive into how sequential logic been used. Let see how we can create a shift register with sequential logic.

A register is a digital circuit that use a group of flip-flops to store multiple bits of binary data (1 or 0). On the other hand, shift register is used to transfer the data in or out from register.

Positive or Negative Edge of the clock signal is used to initiate the bit from moving around the register which make this a sequential logic circuit. In our example, we will be using positive edge triggered of the clock.

Let start creating a shift register module and a main function to call on the shift register. Don't forget to import the ROHD library as the header.

```dart
import 'package:rohd/rohd.dart';

class ShiftRegister extends Module {
    ShiftRegister();
}

void main() async {
    final shiftReg = ShiftRegister();
}
```

Next, let define our inputs to the shift register. So, in our shift register we will need a reset pin - `reset`, shift in pin - `s_in`, clock - `clk`. As for output, there are one pin shift out `s_out`.  

For the output pin `s_out`, we can create a variable `width` to temporary save our width. Let create a 4 bit width signals instead.

Let update out code by adding all the inputs and output and override the name of the module to shift register.

```dart
import 'package:rohd/rohd.dart';

class ShiftRegister extends Module {
  ShiftRegister(Logic clk, Logic reset, Logic sin,
      {super.name = 'shift_register'}) {
    clk = addInput('clk', clk);
    reset = addInput('reset', reset);
    sin = addInput('s_in', sin, width: sin.width);

    final width = 4;
    final sout = addOutput('s_out', width: width);
  }
  Logic get sout => output('s_out');
}

void main() async {
  final reset = Logic(name: 'reset');
  final sin = Logic(name: 's_in');
  final clk = SimpleClockGenerator(10).clk;

  final shiftReg = ShiftRegister(clk, reset, sin);
}
```

Next, we want to create a local signal name `data` that has same `width` with shift-out pin. So, we can resue the variable `width`.

```dart
import 'package:rohd/rohd.dart';

class ShiftRegister extends Module {
  ShiftRegister(Logic clk, Logic reset, Logic sin,
      {super.name = 'shift_register'}) {
    clk = addInput('clk', clk);
    reset = addInput('reset', reset);
    sin = addInput('s_in', sin, width: sin.width);

    final width = 4;
    final sout = addOutput('s_out', width: width);

    // A local signal
    final data = Logic(name: 'data', width: width); // 0000

  }
  Logic get sout => output('s_out');
}

void main() async {
  final reset = Logic(name: 'reset');
  final sin = Logic(name: 's_in');
  final clk = SimpleClockGenerator(10).clk;

  final shiftReg = ShiftRegister(clk, reset, sin);
}
```

Then, it's time to declare the logic of the module. We want to start with creating a sequential block, a `Sequential` block will takes in a clock `clk`, a List of `Conditionals`, and a name for the Sequential (optional).

In our case, we want to pass in `clk` that we generate just now.

```dart
Sequential(clk, []); // Sequential in ROHD
```

For our conditionals, we want to wrap a `IfBlock` that contains a List of `ElseIf` in the Conditionals. Note that the `ElseIf` here also mean `Iff` and `Else` that are implemented in rohd framework. Do not confuse with dart if and else.

```dart
IfBlock() // If block in ROHD
```

So, our logic in the `IfBlock` would be if reset signal is given, we want to set shift out to 0 or else we want to shift the bits to the left (left shift register). We can use the `swizzle()` operation to concatenate the value between 2 logic.

```dart
Sequential(clk, [
  IfBlock([
    Iff(reset, [
      data < 0
    ]),
    Else([
      data < [data.slice(2, 0), sin].swizzle() // left shift
    ])
  ]);
]);
```

So, now our function will look something like this. Let also set the shift out value same as the register.

```dart
import 'package:rohd/rohd.dart';

class ShiftRegister extends Module {
  ShiftRegister(Logic clk, Logic reset, Logic sin,
      {super.name = 'shift_register'}) {
    clk = addInput('clk', clk);
    reset = addInput('reset', reset);
    sin = addInput('s_in', sin, width: sin.width);

    final width = 4;
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
  final sin = Logic(name: 's_in');
  final clk = SimpleClockGenerator(10).clk;

  final shiftReg = ShiftRegister(clk, reset, sin);
}
```

Now, its time for us to test for the simulation. Let start by `build()` our Module. We have to use await to wait for the asynchronous function to finish. After that, let `print` the RTL code of the shift register using `.generateSynth()`. Before we start the simulation, let inject value of 1 to signals `reset` and `sin`.

In time 25, let us put value 0 to turn off the reset signal. Then, we can listen to the value changed using `.logic.changed.listen()` function. When the simulation reach time 100, we want to print the word 'Simulation completed!'. We also save the wave form using the `WaveDumper` module. At the end, we want to wait for the Simulator to run. Hence, we need to use this line `await Simulator.run()`.

```dart
void main() async {
  ...
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
  Simulator.run();
}
```

Any particular reason to use this  data <= {data[2:0], shift_in};
instead of 
data <= {data[0], shift_in};
Yes, there is a reason for that. When you shift data left using {data[0], shift_in}, you will lose the leftmost bit of your register, which may not be desirable in some cases.

In contrast, using {data[2:0], shift_in} ensures that you always keep the leftmost 3 bits of your register, and shift in the new bit at the rightmost position. This is a common way to implement a shift register, and ensures that the register always maintains its width and keeps all previously shifted bits.