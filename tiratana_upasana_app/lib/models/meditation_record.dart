import 'package:objectbox/objectbox.dart';

@Entity()
final class MeditationRecord {
  MeditationRecord({
    required this.meditationStartTime,
    required this.meditationDuration,
    this.id = 0,
    this.meditationNote = '',
  });

  @Id()
  int id = 0;
  final DateTime meditationStartTime;
  final int meditationDuration;
  String meditationNote;
}
