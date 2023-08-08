import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'Features/clock_game/score/logic/score_cubit.dart';
import 'Features/clock_game/settings/logic/settings_cubit.dart';
import 'Features/clock_game/storage/storage_shared_preferences.dart';
import 'Features/darkness_game/util/localization/my_localizations_delegate.dart';
import 'Features/darkness_game/util/sounds.dart';
import 'Features/games_menu/presentation/views/games_menu.dart';

double tileSize = 32;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (!kIsWeb) {
    //await Flame.device.setLandscape();
    //await Flame.device.fullScreen();
  }

  await Sounds.initialize();

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
        child: MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  MyLocalizationsDelegate myLocation = const MyLocalizationsDelegate();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Games',
      debugShowCheckedModeBanner: false,
      home: GamesMenu(),
      supportedLocales: MyLocalizationsDelegate.supportedLocales(),
      localizationsDelegates: [
        myLocation,
        DefaultCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      localeResolutionCallback: myLocation.resolution,
    );
  }
}
