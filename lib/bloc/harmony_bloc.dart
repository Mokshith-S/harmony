import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:harmony/bloc/harmony_event.dart';
import 'package:harmony/bloc/harmony_state.dart';

class HarmonyBloc extends Bloc<HarmonyEvent, HarmonyState> {
  HarmonyBloc() : super(InitialState()) {
    // print(state);
    on<InitialEvent>((event, emit) {
      emit(InitialState());
    });
    on<PlayEvent>((event, emit) {
      emit(PlayState(event.harmonyId));
    });
    on<StopEvent>((event, emit) {
      emit(StopState(event.harmonyId));
    });
  }
}
