import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tiratana_upasana_app/counter/counter.dart';
import 'package:tiratana_upasana_app/meditation_clock/bloc/stopwatch_bloc.dart';

class MeditationWatchPage extends StatelessWidget {
  const MeditationWatchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => StopwatchBloc(),
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
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Meditation Watch'),
          bottom: const TabBar(
            tabs: [
              Tab(
                child: Text('Stopwatch'),
              ),
              Tab(
                child: Text('History'),
              ),
            ],
          ),
        ),
        body: Theme(
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
          child: TabBarView(
            children: [
              LayoutBuilder(
                builder: (context, constraint) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                        flex: 3,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            const SelectableText(
                              'Elapsed time:',
                            ),
                            BlocBuilder<StopwatchBloc, StopwatchState>(
                              builder: (context, state) {
                                final elapsed = state.elapsed;
                                final minutes = ((elapsed / 1000) / 60)
                                    .floor()
                                    .toString()
                                    .padLeft(2, '0');
                                final seconds = ((elapsed / 1000) % 60)
                                    .floor()
                                    .toString()
                                    .padLeft(2, '0');
                                return Text(
                                  '$minutes:$seconds',
                                  style: const TextStyle(
                                    fontSize: 60,
                                    fontWeight: FontWeight.bold,
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      Expanded(
                        flex: 5,
                        child: BlocBuilder<StopwatchBloc, StopwatchState>(
                          builder: (context, state) {
                            return Visibility(
                              visible: state is StopwatchStopped,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  left: 56,
                                  right: 56,
                                  bottom: 16,
                                ),
                                child: TextField(
                                  maxLines: 5,
                                  scrollPhysics: const BouncingScrollPhysics(),
                                  decoration: InputDecoration(
                                    border: const OutlineInputBorder(),
                                    label: const Text('Note'),
                                    hintText: 'Take your note here...',
                                    alignLabelWithHint: true,
                                    floatingLabelAlignment:
                                        FloatingLabelAlignment.center,
                                    suffixIcon: InkWell(
                                      borderRadius: BorderRadius.circular(200),
                                      onTap: () {},
                                      child: const Icon(Icons.close),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      BlocBuilder<StopwatchBloc, StopwatchState>(
                        builder: (context, state) {
                          return Padding(
                            padding: EdgeInsets.only(
                              bottom: (View.of(context).viewInsets.bottom > 0)
                                  ? constraint.maxHeight * 0.08
                                  : constraint.maxHeight * 0.15,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                if (state is StopwatchInitial)
                                  IconButton(
                                    onPressed: () => context
                                        .read<StopwatchBloc>()
                                        .add(const StopwatchStartEvent()),
                                    icon: const Icon(
                                      Icons.play_arrow_outlined,
                                    ),
                                    tooltip: 'Start',
                                  ),
                                if (state is StopwatchRunning)
                                  IconButton(
                                    onPressed: () => context
                                        .read<StopwatchBloc>()
                                        .add(const StopwatchStopEvent()),
                                    icon: const Icon(
                                      Icons.stop_outlined,
                                    ),
                                    tooltip: 'Stop',
                                  ),
                                if (state is StopwatchStopped)
                                  IconButton(
                                    onPressed: () => context
                                        .read<StopwatchBloc>()
                                        .add(const StopwatchResetEvent()),
                                    icon: const Icon(
                                      Icons.check,
                                    ),
                                    tooltip: 'Submit',
                                  ),
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  );
                },
              ),
              const Center(
                child: Text('Hello'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CounterText extends StatelessWidget {
  const CounterText({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final count = context.select((CounterCubit cubit) => cubit.state);
    return Text('$count', style: theme.textTheme.displayLarge);
  }
}
