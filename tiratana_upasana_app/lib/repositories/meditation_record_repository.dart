import 'package:objectbox/objectbox.dart';

final class MeditationRecordRepository {
  MeditationRecordRepository({
    required Store store,
  }) {
    _store = store;
  }

  late final Store _store;

  Store get store => _store;
}
