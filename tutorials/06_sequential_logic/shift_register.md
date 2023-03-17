# Sequential Logic (Shift Register)

From the previous section, you saw how a combinational logic is used in the ROHD module. Today, we are going to dive into how sequential logic been used. Let see how we can create a shift register with sequential logic. 

A register is a digital circuit that use group of flip-flops to store multiple bits of binary data (1 or 0). On the other hand, shift register is used to transfer the data in or out from register. 

Positive or Negative Edge of the clock signal is used to initiate the bit from moving around the register which make this a sequential logic circuit.

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

Let update out code by adding all the inputs and output and override the name of the module to shift register. 


```dart
import 'package:rohd/rohd.dart';

class ShiftRegister extends Module {
  ShiftRegister(Logic clk, Logic reset, Logic sin,
      {super.name = 'shift_register'}) {
    clk = addInput('clk', clk);
    reset = addInput('reset', reset);
    sin = addInput('s_in', sin);
  }
}

void main() async {
  final reset = Logic(name: 'reset');
  final sin = Logic(name: 's_in');
  final clk = SimpleClockGenerator(10).clk;

  final shiftReg = ShiftRegister(clk, reset, sin);
}
```

Next, we want to declare two local signal that can represent a register and a nextvalue to execute. Let declare both of the signals as bus with the width of 8.

```dart
import 'package:rohd/rohd.dart';

class ShiftRegister extends Module {
  ShiftRegister(Logic clk, Logic reset, Logic sin,
      {super.name = 'shift_register'}) {
    clk = addInput('clk', clk);
    reset = addInput('reset', reset);
    sin = addInput('s_in', sin);

    final sout = addOutput('s_out');
  }
}

void main() async {
  final reset = Logic(name: 'reset');
  final sin = Logic(name: 's_in');
  final clk = SimpleClockGenerator(10).clk;

  final shiftReg = ShiftRegister(clk, reset, sin);

  // A local signal
  const width = 8;
  var rReg = Logic(name: 'r_reg', width: width);
  var rNext = Logic(name: 'r_next', width: width); 
}
```

Then, its time to declare the logic of the register. 

```dart
import 'package:rohd/rohd.dart';

class ShiftRegister extends Module {
  ShiftRegister(Logic clk, Logic reset, Logic sin,
      {super.name = 'shift_register'}) {
    clk = addInput('clk', clk);
    reset = addInput('reset', reset);
    sin = addInput('s_in', sin);

    final sout = addOutput('s_out');

    // A local signal
    const width = 8;
    var rReg = Logic(name: 'r_reg', width: width);
    var rNext = Logic(name: 'r_next', width: width);

    Sequential(clk, [
      IfBlock([
        Iff(reset, [
          rReg < 0,
        ]),
        Else([
          rReg < rNext,
        ]),
      ]),
    ]);

    rNext <= [sin, rReg.slice(width - 1, 1)].swizzle(); // right shift
    sout <= rReg[0];
  }
}

void main() async {
  final reset = Logic(name: 'reset');
  final sin = Logic(name: 's_in');
  final clk = SimpleClockGenerator(10).clk;

  final shiftReg = ShiftRegister(clk, reset, sin);

  // A local signal
  const width = 8;
  var rReg = Logic(name: 'r_reg', width: width);
  var rNext = Logic(name: 'r_next', width: width);
}
```

Now, its time for us to test for the simulation. 




Any particular reason to use this  data <= {data[2:0], shift_in};
instead of 
data <= {data[0], shift_in};
Yes, there is a reason for that. When you shift data left using {data[0], shift_in}, you will lose the leftmost bit of your register, which may not be desirable in some cases.

In contrast, using {data[2:0], shift_in} ensures that you always keep the leftmost 3 bits of your register, and shift in the new bit at the rightmost position. This is a common way to implement a shift register, and ensures that the register always maintains its width and keeps all previously shifted bits.