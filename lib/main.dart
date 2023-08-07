import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'Features/clock_game/score/logic/score_cubit.dart';
import 'Features/clock_game/settings/logic/settings_cubit.dart';
import 'Features/clock_game/storage/storage_shared_preferences.dart';
import 'Features/games_menu/presentation/views/games_menu.dart';

void main() {
  runApp(
    RepositoryProvider(
      create: (context) => StorageSharedPreferences(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => ScoreCubit(
              context.read<StorageSharedPreferences>(),
            ),
          ),
          BlocProvider(
            create: (context) => SettingsCubit(
              context.read<StorageSharedPreferences>(),
            ),
            lazy: false,
          ),
        ],
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    return const MaterialApp(
      title: 'Games',
      debugShowCheckedModeBanner: false,
      home: GamesMenu(),
    );
  }
}
