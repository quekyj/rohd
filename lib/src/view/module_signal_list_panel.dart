import 'package:devtools_app_shared/ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fancy_tree_view/flutter_fancy_tree_view.dart';
import 'package:rohd_wave_viewer/src/models/waveform_mock.dart';
import 'package:rohd_wave_viewer/src/models/waveform_model.dart';
import 'package:rohd_wave_viewer/src/providers/selected_module_provider.dart';
import 'package:rohd_wave_viewer/src/providers/selected_signals_list_provider.dart';
import 'package:rohd_wave_viewer/src/ui/module_signal_card.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ModuleSignalsListPanel extends ConsumerStatefulWidget {
  const ModuleSignalsListPanel({
    super.key,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ModuleSignalsListPanelState();
}

class _ModuleSignalsListPanelState
    extends ConsumerState<ModuleSignalsListPanel> {
  late final TreeController<Module> treeController;
  late final WaveformModel waveformModel = generateWaveFormNode();

  @override
  void initState() {
    super.initState();

    treeController = TreeController<Module>(
      roots: waveformModel.modules,
      childrenProvider: (Module module) => module.subModules,
    );
  }

  @override
  void dispose() {
    treeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Split(
      axis: Axis.vertical,
      initialFractions: const [0.5, 0.5],
      children: [
        ModuleSignalCard(
          cardTitle: 'Modules',
          cardBody: Expanded(
            child: TreeView<Module>(
              treeController: treeController,
              nodeBuilder: (BuildContext context, TreeEntry<Module> entry) {
                return MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: () {
                      ref
                          .read(selectedModuleProvider.notifier)
                          .setModule(entry.node);
                    },
                    child: TreeIndentation(
                      entry: entry,
                      child: Row(
                        children: [
                          ExpandIcon(
                            key: GlobalObjectKey(entry.node),
                            isExpanded: entry.isExpanded,
                            onPressed: (_) =>
                                treeController.toggleExpansion(entry.node),
                          ),
                          Flexible(
                            child: Text(entry.node.name),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          headerAction: <Widget>[
            IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
            IconButton(onPressed: () {}, icon: const Icon(Icons.refresh)),
          ],
        ),
        ModuleSignalCard(
          cardTitle: 'Signals',
          cardBody: Expanded(
            child: ListView(
              children: _populateSignals(),
            ),
          ),
          headerAction: <Widget>[
            IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
          ],
        ),
      ],
    );
  }

  List<Widget> _populateSignals() {
    final module = ref.watch(selectedModuleProvider);

    if (module != null) {
      return module.signals
          .map(
            (signal) => Padding(
              padding: const EdgeInsets.only(top: 5, left: 10),
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onDoubleTap: () {
                    ref
                        .read(selectedSignalsListProvider.notifier)
                        .addSignals(signal);
                  },
                  child: Text(signal.name),
                ),
              ),
            ),
          )
          .toList();
    }

    return [];
  }
}
