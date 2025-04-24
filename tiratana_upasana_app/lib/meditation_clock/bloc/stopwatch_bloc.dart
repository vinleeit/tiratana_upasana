import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'stopwatch_event.dart';
part 'stopwatch_state.dart';

class StopwatchBloc extends Bloc<MeditationTimerEvent, MeditationTimerState> {
  StopwatchBloc() : super(const MeditationTimerInitial()) {
    on<StartTimer>(_onStartTimer);
    on<_TimerTick>(_onTimerTick);
    on<StopTimer>(_onStopTimer);
    on<UpdateNote>(_onUpdateNote);
    on<SaveRecord>(_onSaveRecord);
  }

  static const int _tickDuration = 1000; // milliseconds
  Timer? _timer;

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }

  void _onStartTimer(StartTimer event, Emitter<MeditationTimerState> emit) {
    if (state is MeditationTimerInitial) {
      emit(
        MeditationTimerRunning(
          startTime: DateTime.now(),
          elapsed: state.elapsed,
        ),
      );
      _timer?.cancel();
      _timer = Timer.periodic(
        const Duration(milliseconds: _tickDuration),
        (timer) => add(_TimerTick(elapsed: state.elapsed + _tickDuration)),
      );
    }
  }

  void _onTimerTick(_TimerTick event, Emitter<MeditationTimerState> emit) {
    emit(
      MeditationTimerRunning(
        startTime: state.startTime,
        elapsed: event.elapsed,
      ),
    );
  }

  void _onStopTimer(StopTimer event, Emitter<MeditationTimerState> emit) {
    if (state is MeditationTimerRunning) {
      _timer?.cancel();
      emit(
        MeditationTimerStopped(
          startTime: state.startTime,
          elapsed: state.elapsed,
          note: '',
        ),
      );
    }
  }

  void _onUpdateNote(UpdateNote event, Emitter<MeditationTimerState> emit) {
    if (state is MeditationTimerStopped) {
      final currentState = state as MeditationTimerStopped;
      emit(
        MeditationTimerStopped(
          startTime: currentState.startTime,
          elapsed: currentState.elapsed,
          note: event.note,
        ),
      );
    }
  }

  Future<void> _onSaveRecord(
    SaveRecord event,
    Emitter<MeditationTimerState> emit,
  ) async {
    if (state is MeditationTimerStopped) {
      final currentState = state as MeditationTimerStopped;
      try {
        // TODO: Save data to database
        emit(const MeditationTimerInitial());
      } catch (e) {
        // TODO: Add error state
      }
    }
  }
}
