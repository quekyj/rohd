import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_simple_treeview/flutter_simple_treeview.dart';
import 'package:rohd_devtools_extension/src/modules/tree_structure/models/tree_module.dart';
import 'package:rohd_devtools_extension/src/modules/tree_structure/providers/selected_module_provider.dart';
import 'package:rohd_devtools_extension/src/modules/tree_structure/providers/tree_search_term_provider.dart';
import 'package:rohd_devtools_extension/src/modules/tree_structure/providers/tree_service_provider.dart';
import 'package:rohd_devtools_extension/src/modules/tree_structure/services/tree_service.dart';

class ModuleTreeWidget extends ConsumerWidget {
  late AsyncValue<TreeModel> futureModuleTree;

  ModuleTreeWidget({super.key, required this.futureModuleTree});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return genModuleTree(
      ref: ref,
      moduleTreeAsyncValue: futureModuleTree,
    );
  }

  TreeNode? buildNode(TreeModel module, {required WidgetRef ref}) {
    final TreeService treeService = ref.read(treeServiceProvider);
    final treeSearchTerm = ref.watch(treeSearchTermProvider);
    // If there's a search term, ensure that either this node or a descendant node matches it.
    if (treeSearchTerm != null &&
        !treeService.isNodeOrDescendentMatching(module, treeSearchTerm)) {
      return null;
    }

    // Build children recursively
    List<TreeNode> childrenNodes = buildChildrenNodes(module, ref: ref);

    return TreeNode(
      content: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: () {
            ref.read(selectedModuleProvider.notifier).setModule(module);
          },
          child: getNodeContent(module),
        ),
      ),
      children: childrenNodes,
    );
  }

  Widget getNodeContent(TreeModel module) {
    return Row(
      children: [
        const Icon(Icons.memory),
        const SizedBox(width: 2.0),
        Text(module.name),
      ],
    );
  }

  List<TreeNode> buildChildrenNodes(TreeModel treeModule,
      {required WidgetRef ref}) {
    List<TreeNode?> childrenNodes = [];
    List<dynamic> subModules = treeModule.subModules;
    if (subModules.isNotEmpty) {
      for (var module in subModules) {
        TreeNode? node = buildNode(module, ref: ref);
        if (node != null) {
          childrenNodes.add(node);
        }
      }
    }
    return childrenNodes
        .where((node) => node != null)
        .toList()
        .cast<TreeNode>();
  }

  TreeNode? buildTreeFromModule(TreeModel node, {required WidgetRef ref}) {
    return buildNode(node, ref: ref);
  }

  Widget genModuleTree({
    required AsyncValue<TreeModel> moduleTreeAsyncValue,
    required WidgetRef ref,
  }) {
    return moduleTreeAsyncValue.when(
      data: (TreeModel data) {
        var root = buildNode(data, ref: ref);
        if (root != null) {
          return TreeView(nodes: [root]);
        } else {
          return Text('No data');
        }
      },
      error: (error, stackTrace) => Text('Error: $error'),
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}