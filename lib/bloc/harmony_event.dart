sealed class HarmonyEvent {}

final class InitialEvent extends HarmonyEvent {}

final class PlayEvent extends HarmonyEvent {
  PlayEvent(this.harmonyId);

  final String harmonyId;
}

final class StopEvent extends HarmonyEvent {
  final String harmonyId;

  StopEvent(this.harmonyId);
}
