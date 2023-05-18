# Content

- [What is ROHD Cosim](#what-is-rohd-cosim)
- [Pre-requisite](#pre-requisite)
- [Using ROHD Cosimulation](#using-rohd-cosimulation)
  - [Step 1: Wrap your System Verilog Module](#step-1-wrap-your-system-verilog-module)
  - [Step 2: Generate a connector and start the cosimulation](#step-2-generate-a-connector-and-start-the-cosimulation)
    - [Additional Information](#additional-information)
- [Counter Module With ROHD Cosim](#counter-module-with-rohd-cosim)

## Learning Outcome

In this chapter:

- You learn what is rohd-cosim and how to co-simulate system verilog code with ROHD dart RTL design.

## What is ROHD Cosim?

Imagine a situation where you designed a piece of hardware using ROHD. Then, you suddenly wish to reuse a piece of old design that are written in system verilog. Here, we have ROHD Cosim come to your rescue.

ROHD Framework Co-simulation (ROHD Cosim) is a dart package built upon ROHD for cosimulate between ROHD Simulator and a System Verilog simulator.

You might find yourselves using ROHD Cosim in:

- Instantiating a System Verilog module within a ROHD Module and running a simulation
- Using ROHD and ROHD-VF to build a testbench for SystemVerilog module
- Connecting and simulating a ROHD and ROHD-VF developed functional model to empty shell located within SystemVerilog hierarchy
- Developing a mixed-simulation model where portions of design and/or testbench are in ROHD/ROHD-VF and other are in SystemVerilog or other languages which can run in or interact with a SystemVerilog simulator

When you instantiate a SystemVerilog module within the ROHD simulator with ROHD Cosim, from the perspective of the rest of the ROHD environment it looks just like any other ROHD module. You can run simulations, set breakpoints and debug, etc. even with the SystemVerilog simulator running in cosimulation.

## Pre-requisite

ROHD Cosim relies on python package called `cocotb` and its GPI library for communicating with SystemVerilog Simulators.

You can find the installation guide for `cocotb` at [https://docs.cocotb.org/en/stable/install.html](https://docs.cocotb.org/en/stable/install.html). The instruction generally boil down to:

```dart
pip install cocotb
```

You will need your favourite SystemVerilog simulator to do simulation between ROHD and SystemVerilog modules. ROHD Cosim does not do any SystemVerilog parsing and SystemVerilog simulation.

## Using ROHD Cosimulation

There are two steps to use ROHD Cosim.

### Step 1: Wrap your System Verilog Module

Wrap your SystemVerilog module with ROHD's `ExternalSystemVerilogModule` and apply the `Cosim` mixin.

For example, here are the corresponding SystemVerilog module definitions and a wrapper for it with Cosim.

```dart
// example_cosim_module.v
module my_cosim_test_module(
    input logic a,
    input logic b,
    output logic a_bar,
    output logic b_same,
    output logic c_none
);

assign a_bar = ~a;
assign b_same = b;
assign c_none = 0;

endmodule
```

```dart
// example_cosim_module.dart
class ExampleCosimModule extends ExternalSystemVerilogModule with Cosim {
  Logic get aBar => output('a_bar');
  Logic get bSame => output('b_same');

  @override
  List<String> get verilogSources => ['./example_cosim_module.v'];

  ExampleCosimModule(Logic a, Logic b, {String name = 'ecm'})
      : super(definitionName: 'my_cosim_test_module', name: name) {
    addInput('a', a);
    addInput('b', b);
    addOutput('a_bar');
    addOutput('b_same');
    addOutput('c_none');
  }
}
```

You can add inputs and outputs using any mechanism, including ROHD `Interface`.

### Step 2: Generate a connector and start the cosimulation

Call the `Cosim.connectToSimulation` function with an appropriate configuration after `Module.build` to connect to the SystemVerilog simulator.

```dart
await Cosim.connectToSimulation(
    CosimWrapConfig(
        // The SystemVerilog will simulate with Icarus Verilog
        SystemVerilogSimulator.icarus,

        // We can choose to generate waves from SystemVerilog Simulator
        dumpWaves: false

        // Let's specify where we want our SystemVerilog simulation to run.
        // This is the directory where temporary files, waves, and output
        // logs may appear.
        directory: './example/tmp_cosim/'
    )
);
```

#### Additional Information

- Note that ROHD Simulator must be running in order for cosimulator to execute
- Note that with the cosimulator process running in a unit test suite, you have an additional thing to reset each `tearDown: Cosim.reset()`
- The `example/` directory has a counter example similar to what's available in the ROHD and ROHD-VF examples
- The ROHD Cosim test suite in `test/` is a good reference for some examples of how to set things up

## Counter Module with ROHD Cosim

Let see how we can run a counter module [counter.sv](counter.sv) using ROHD cosimulation. So, we have counter module that is written in system verilog code and we want to run it in the ROHD environment.

We have a counter system verilog. The content of the file is listed as below:

```sv
module Counter(
    input logic en,
    input logic reset,
    input logic clk,
    output logic [7:0] val
    );
    logic [7:0] nextVal;
    //  sequential
    always_ff @(posedge clk) begin
      if(reset) begin
          val <= 8'h0;
      end else begin
          if(en) begin
              val <= nextVal;
          end 
    
      end 
    
    end
    
    assign nextVal = val + 8'h1;  // add
endmodule : Counter
```

Still remember out step 1? Yes, we need to wrap your SystemVerilog module with ROHD's `ExternalSystemVerilogModule` and apply the `Cosim` mixin.

Let start by importing the packages and create the module. We can also map interesting outputs to short variable names for consumers of this module.

```dart
// Import the ROHD package.
import 'package:rohd/rohd.dart';

// Import the ROHD Cosim package.
import 'package:rohd_cosim/rohd_cosim.dart';

// Define a class Counter that extends ROHD's abstract
// `ExternalSystemVerilogModule` class and add the `Cosim` mixin.
class Counter extends ExternalSystemVerilogModule with Cosim {
    // For convenience, map interesting outputs to short variable names for consumers of this module.
    Logic get val => output('val');

    // This counter was written with 8-bit width.
    static const int width = 8;
}
```

Next, we need to provide the sources of the system verilog that we want to perform cosimulation.

```dart
class Counter extends ExternalSystemVerilogModule with Cosim {
    ...

    // We must provide instructions for where to find the SystemVerilog that
    // is used to build the wrapped module.
    // Note that the path is relative to where we will configure the SystemVerilog
    // simulator to be running.
    @override
    List<String>? get verilogSources => ['../counter.sv'];
}
```

Then, we need to create the constructor that have defined inputs and outputs.

```dart
class Counter extends ExternalSystemVerilogModule with Cosim {
    ...

    Counter(Logic en, Logic reset, Logic clk, {super.name = 'counter'})
      // The `definitionName` is the name of the SystemVerilog module
      // we're instantiating.
      : super(definitionName: 'Counter') {
        // Register inputs and outputs of the module in the constructor.
        // These name *must* match the names of the ports in the SystemVerilog
        // module that we are wrapping.
        en = addInput('en', en);
        reset = addInput('reset', reset);
        clk = addInput('clk', clk);
        addOutput('val', width: width);
    }
},
```

So, our `Counter` external system verilog module is done. We can now work on the Simulation. Let start by creating the `main()` function as usual to test on our module. Let define our inputs `clk`, `en`, and `reset`. We can also create a `counter` Module and `build()` it.

```dart
Future<void> main({bool noPrint = false}) async {
  // Define some local signals.
  final en = Logic(name: 'en');
  final reset = Logic(name: 'reset');

  // Generate a simple clock.  This will run along by itself as
  // the Simulator goes.
  final clk = SimpleClockGenerator(10).clk;

  // Make our cosimulated counter.
  final counter = Counter(en, reset, clk);

  // Before we can simulate or generate code with the counter, we need
  // to build it.
  await counter.build();
}
```

Still remember we talked previously, to simulate ROHD cosim, we need to use `Cosim.connectCosimulation()`. Let wrap our configuration `ConsimWrapConfig()` with `SystemVerilogSimulator.icarus`, generate waveform with `dumpWaves: !noPrint` and the directory is `./example/tmp_cosim/`.

```dart
Future<void> main({bool noPrint = false}) async {
  ...
  // **Important for Cosim!**
  // We must connect to the cosimulation process with configuration information.
  await Cosim.connectCosimulation(CosimWrapConfig(
    // The SystemVerilog will simulate with Icarus Verilog
    SystemVerilogSimulator.icarus,

    // We can generate waves from the SystemVerilog simulator.
    dumpWaves: !noPrint,

    // Let's specify where we want our SystemVerilog simulation to run.
    // This is the directory where temporary files, waves, and output
    // logs may appear.
    directory: './example/tmp_cosim/',
  ));
}
```

And now, we can try to simulate our `Counter` module with ROHD `Simulator`.

```dart
Future<void> main({bool noPrint = false}) async {
  ...
  // Now let's try simulating!
  // Let's start off with a disabled counter and asserting reset.
  en.inject(0);
  reset.inject(1);

  // Attach a waveform dumper so we can see what happens in the ROHD simulator.
  // Note that this is a separate VCD file from what the SystemVerilog simulator
  // will dump out.
  if (!noPrint) {
    WaveDumper(counter, outputPath: './example/tmp_cosim/rohd_waves.vcd');
  }

  // Drop reset at time 25.
  Simulator.registerAction(25, () => reset.put(0));

  // Raise enable at time 45.
  Simulator.registerAction(45, () => en.put(1));

  // Print a message every time the counter value changes.
  counter.val.changed.listen((event) {
    if (!noPrint) {
      print('Value of the counter changed @${Simulator.time}: $event');
    }
  });

  // Print a message when we're done with the simulation!
  Simulator.registerAction(100, () {
    if (!noPrint) {
      print('Simulation completed!');
    }
  });

  // Set a maximum time for the simulation so it doesn't keep running forever.
  Simulator.setMaxSimTime(100);

  // Kick off the simulation.
  await Simulator.run();

  // We can take a look at the waves now.
  if (!noPrint) {
    print('To view waves, check out waves with a waveform viewer'
        ' (e.g. `gtkwave waves.vcd` and `gtkwave rohd_waves.vcd`).');
  }
}
```

Congratulation! You have successfully run external system verilog code in ROHD ecosystem. You can find the executable code at [counter_cosim.dart](./counter_cosim.dart).
