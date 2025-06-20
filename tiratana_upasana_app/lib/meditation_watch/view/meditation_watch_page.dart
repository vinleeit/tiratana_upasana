import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tiratana_upasana_app/meditation_watch/bloc/history_bloc.dart';
import 'package:tiratana_upasana_app/meditation_watch/bloc/stopwatch_bloc.dart';
import 'package:tiratana_upasana_app/meditation_watch/view/history_view.dart';
import 'package:tiratana_upasana_app/meditation_watch/view/watch_view.dart';
import 'package:tiratana_upasana_app/repositories/app_cache_repository.dart';
import 'package:tiratana_upasana_app/repositories/meditation_record_repository.dart';

class MeditationWatchPage extends StatelessWidget {
  const MeditationWatchPage({super.key});

  @override
  Widget build(BuildContext context) {
    final meditationRecordRepository =
        context.read<MeditationRecordRepository>();
    final appCacheRepository = context.read<AppCacheRepository>();
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => StopwatchBloc(
            appCacheRecordRepository: appCacheRepository,
            meditationRecordRepository: meditationRecordRepository,
          )..add(const InitializeMeditationTimer()),
        ),
        BlocProvider(
          create: (_) => HistoryBloc(
            meditationRecordRepository: meditationRecordRepository,
          )..add(InitializeHistory()),
        ),
      ],
      child: const MeditationWatchView(),
    );
  }
}

class MeditationWatchView extends StatelessWidget {
  const MeditationWatchView({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          const TabBar(
            tabs: [
              Tab(
                child: Text('Stopwatch'),
              ),
              Tab(
                child: Text('History'),
              ),
            ],
          ),
          Theme(
            data: Theme.of(context).copyWith(
              iconButtonTheme: IconButtonThemeData(
                style: ButtonStyle(
                  iconSize: WidgetStateProperty.all(42),
                  shape: WidgetStateProperty.all(
                    RoundedRectangleBorder(
                      side: const BorderSide(
                        color: Colors.black54,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(200),
                    ),
                  ),
                ),
              ),
            ),
            child: const Expanded(
              child: TabBarView(
                children: [
                  WatchView(),
                  HistoryView(),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
