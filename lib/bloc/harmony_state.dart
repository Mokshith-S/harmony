sealed class HarmonyState {}

final class InitialState extends HarmonyState {}

final class PlayState extends HarmonyState {
  PlayState(this.harmonyId);

  final String harmonyId;
}

final class StopState extends HarmonyState {
  StopState(this.harmonyId);

  final String harmonyId;
}
