import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:rohd_wave_viewer/src/models/waveform_model.dart';

part 'selected_module_provider.g.dart';

@riverpod
class SelectedModule extends _$SelectedModule {
  @override
  Module? build() {
    return null;
  }

  void setModule(Module module) {
    state = module;
  }
}
