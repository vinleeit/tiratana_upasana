import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'stopwatch_event.dart';
part 'stopwatch_state.dart';

class StopwatchBloc extends Bloc<StopwatchEvent, StopwatchState> {
  StopwatchBloc() : super(const StopwatchInitial()) {
    on<StopwatchStartEvent>(_onStart);
    on<StopwatchStopEvent>(_onStop);
    on<StopwatchResetEvent>(_onReset);
    on<_StopwatchTickEvent>(_onTick);
  }

  static const int _tickDuration = 1000; // milliseconds
  Timer? _timer;

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }

  void _onStart(StopwatchStartEvent event, Emitter<StopwatchState> emit) {
    emit(StopwatchRunning(state.elapsed, DateTime.now()));
    _timer?.cancel();
    _timer = Timer.periodic(
      const Duration(milliseconds: _tickDuration),
      (timer) =>
          add(_StopwatchTickEvent(elapsed: state.elapsed + _tickDuration)),
    );
  }

  void _onStop(StopwatchStopEvent event, Emitter<StopwatchState> emit) {
    debugPrint('Stopped: ${state.elapsed} | ${state.startTime}');
    if (state is StopwatchRunning) {
      _timer?.cancel();
      emit(StopwatchStopped(state.elapsed, state.startTime));
    }
  }

  void _onTick(_StopwatchTickEvent event, Emitter<StopwatchState> emit) {
    emit(StopwatchRunning(event.elapsed, state.startTime));
  }

  void _onReset(StopwatchResetEvent event, Emitter<StopwatchState> emit) {
    emit(const StopwatchInitial());
  }
}
