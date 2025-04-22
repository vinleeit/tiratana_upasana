part of 'stopwatch_bloc.dart';

sealed class StopwatchEvent {
  const StopwatchEvent();
}

final class StopwatchStartEvent extends StopwatchEvent {
  const StopwatchStartEvent();
}

final class StopwatchStopEvent extends StopwatchEvent {
  const StopwatchStopEvent();
}

final class StopwatchResetEvent extends StopwatchEvent {
  const StopwatchResetEvent();
}

class _StopwatchTickEvent extends StopwatchEvent {
  const _StopwatchTickEvent({required this.elapsed});

  final int elapsed;
}
