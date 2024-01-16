import 'package:devtools_app_shared/ui.dart';
import 'package:flutter/material.dart';
import 'package:rohd_wave_viewer/src/ui/module_signal_card.dart';

class ModuleSignalsListPanel extends StatelessWidget {
  const ModuleSignalsListPanel({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Split(
      axis: Axis.vertical,
      initialFractions: const [0.5, 0.5],
      children: [
        ModuleSignalCard(
          cardTitle: 'Modules',
          cardBody: const Center(
            child: Text('Module Tree'),
          ),
          headerAction: <Widget>[
            IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
            IconButton(onPressed: () {}, icon: const Icon(Icons.refresh)),
          ],
        ),
        ModuleSignalCard(
          cardTitle: 'Signals',
          cardBody: const Center(
            child: Text('Signals List'),
          ),
          headerAction: <Widget>[
            IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
          ],
        ),
      ],
    );
  }
}
