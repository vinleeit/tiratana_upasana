import 'package:hive_ce_flutter/hive_flutter.dart';

part 'meditation_record.g.dart';

@HiveType(typeId: 10)
final class MeditationRecord {
  const MeditationRecord({
    required this.startDatetime,
    required this.duration,
    this.note = '',
  });

  factory MeditationRecord.fromJson(Map<String, dynamic> json) {
    return MeditationRecord(
      startDatetime: DateTime.parse(json['startDateTime'] as String),
      duration: Duration(
        seconds: int.parse(json['duration'] as String),
      ),
      note: json['note'] as String,
    );
  }

  @HiveField(0)
  final DateTime startDatetime;
  @HiveField(1)
  final Duration duration;
  @HiveField(2)
  final String note;

  Map<String, dynamic> toJson() {
    return {
      'startDateTime': startDatetime.toIso8601String(),
      'duration': duration.inSeconds,
      'note': note,
    };
  }
}
