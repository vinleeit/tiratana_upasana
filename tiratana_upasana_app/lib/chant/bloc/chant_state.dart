part of 'chant_bloc.dart';

@immutable
sealed class ChantState extends Equatable {
  const ChantState({
    required this.chants,
    required this.currentChantIndex,
  });

  final List<Chant> chants;
  final int currentChantIndex;

  Chant? get currentChant =>
      (chants.isEmpty) ? null : chants[currentChantIndex];

  @override
  List<Object?> get props => [
        chants,
        currentChantIndex,
        () => currentChant?.selectedContent.iso,
      ];
}

final class ChantInitialState extends ChantState {
  const ChantInitialState({
    super.chants = const [],
    super.currentChantIndex = 0,
  });
}

final class ChantReadyState extends ChantState {
  const ChantReadyState({
    required super.chants,
    required super.currentChantIndex,
  });
}
