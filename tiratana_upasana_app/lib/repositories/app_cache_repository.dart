import 'package:objectbox/objectbox.dart';
import 'package:tiratana_upasana_app/models/app_cache.dart';

final class AppCacheRepository {
  AppCacheRepository({
    required Store store,
  }) {
    _store = store;
  }

  late final Store _store;

  AppCache get data {
    final box = _store.box<AppCache>();
    var data = box.get(1);
    if (data == null) {
      data = AppCache();
      box.put(data);
    }
    return data;
  }

  set data(AppCache data) {
    final box = _store.box<AppCache>();
    data.id = 1;
    box.put(data, mode: PutMode.update);
  }
}
