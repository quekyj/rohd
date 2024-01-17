import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:rohd_wave_viewer/src/models/waveform_model.dart';

part 'selected_signals_list_provider.g.dart';

@riverpod
class SelectedSignalsList extends _$SelectedSignalsList {
  @override
  List<Signal> build() {
    return [];
  }

  void addSignals(Signal signal) {
    state = [...state, signal];
  }
}
