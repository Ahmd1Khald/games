import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'Core/helpers/dio_helper.dart';
import 'Core/services/BlocObserver.dart';
import 'Core/services/ServiceLocator.dart';
import 'Features/clock_game/score/logic/score_cubit.dart';
import 'Features/clock_game/settings/logic/settings_cubit.dart';
import 'Features/clock_game/storage/storage_shared_preferences.dart';
import 'Features/darkness_game/util/sounds.dart';
import 'Features/games_menu/presentation/views/games_menu.dart';

double tileSize = 32;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  setUpServiceLocator();
  // if (!kIsWeb) {
  //   //await Flame.device.setLandscape();
  //   //await Flame.device.fullScreen();
  // }

  await Sounds.initialize();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);

  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  //   DeviceOrientation.portraitDown,
  // ]);

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
  //MyLocalizationsDelegate myLocation = const MyLocalizationsDelegate();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Games',
      debugShowCheckedModeBanner: false,
      home: GamesMenu(),
      //supportedLocales: MyLocalizationsDelegate.supportedLocales(),
      // localizationsDelegates: [
      //   myLocation,
      //   DefaultCupertinoLocalizations.delegate,
      //   GlobalMaterialLocalizations.delegate,
      //   GlobalWidgetsLocalizations.delegate,
      // ],
      //localeResolutionCallback: myLocation.resolution,
    );
  }
}
