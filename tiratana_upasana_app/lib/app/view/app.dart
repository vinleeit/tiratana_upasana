import 'package:flutter/material.dart';
import 'package:tiratana_upasana_app/l10n/arb/app_localizations.dart';
import 'package:tiratana_upasana_app/meditation_clock/view/meditation_clock_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
      ),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: const MeditationWatchPage(),
    );
  }
}
