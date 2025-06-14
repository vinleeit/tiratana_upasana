import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tiratana_upasana_app/l10n/arb/app_localizations.dart';
import 'package:tiratana_upasana_app/meditation_watch/view/meditation_watch_page.dart';
import 'package:tiratana_upasana_app/repositories/meditation_record_repository.dart';
import 'package:tiratana_upasana_app/repositories/store_repository.dart';

class App extends StatelessWidget {
  const App({
    required StoreRepository storeRepository,
    super.key,
  }) : _storeRepository = storeRepository;

  final StoreRepository _storeRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<StoreRepository>.value(
      value: _storeRepository,
      child: MultiRepositoryProvider(
        providers: [
          RepositoryProvider<MeditationRecordRepository>(
            create: (_) =>
                MeditationRecordRepository(store: _storeRepository.store),
          ),
        ],
        child: MaterialApp(
          title: 'Tiratana Upasana',
          theme: ThemeData(
            useMaterial3: true,
          ),
          debugShowCheckedModeBanner: false,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: const MeditationWatchPage(),
        ),
      ),
    );
  }
}
