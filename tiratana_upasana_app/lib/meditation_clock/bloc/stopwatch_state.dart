part of 'stopwatch_bloc.dart';

sealed class StopwatchState {
  const StopwatchState(this.elapsed, this.startTime);

  final int elapsed;
  final DateTime? startTime;
}

final class StopwatchInitial extends StopwatchState {
  const StopwatchInitial() : super(0, null);
}

final class StopwatchRunning extends StopwatchState {
  const StopwatchRunning(super.elapsed, super.startTime);
}

final class StopwatchStopped extends StopwatchState {
  const StopwatchStopped(super.elapsed, super.startTime);
}
