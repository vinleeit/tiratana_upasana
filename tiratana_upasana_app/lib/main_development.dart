import 'package:tiratana_upasana_app/app/app.dart';
import 'package:tiratana_upasana_app/bootstrap.dart';
import 'package:tiratana_upasana_app/repositories/store_repository.dart';

void main() {
  bootstrap(() async {
    final storeRepository = StoreRepository();
    await storeRepository.initStore();
    return App(
      storeRepository: storeRepository,
    );
  });
}
