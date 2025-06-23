import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tiratana_upasana_app/chant/bloc/chant_bloc.dart';
import 'package:tiratana_upasana_app/chant/view/chant_view.dart';
import 'package:tiratana_upasana_app/repositories/app_cache_repository.dart';

class ChantPage extends StatelessWidget {
  const ChantPage({super.key});

  @override
  Widget build(BuildContext context) {
    final appCacheRepository = context.read<AppCacheRepository>();
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => ChantBloc(
            appCacheRepository: appCacheRepository,
          )..add(InitializeChant()),
        ),
      ],
      child: const ChantView(),
    );
  }
}
