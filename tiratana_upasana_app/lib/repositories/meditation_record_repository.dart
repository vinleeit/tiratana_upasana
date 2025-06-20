import 'package:objectbox/objectbox.dart';
import 'package:tiratana_upasana_app/models/meditation_record.dart';

final class MeditationRecordRepository {
  MeditationRecordRepository({
    required Store store,
  }) {
    _store = store;
  }

  late final Store _store;

  Box<MeditationRecord> get box => _store.box<MeditationRecord>();
}
