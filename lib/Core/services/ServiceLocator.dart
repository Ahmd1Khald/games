import 'package:get_it/get_it.dart';

import '../../Features/games_menu/data/data_sources/games_remote_data_source.dart';
import '../../Features/games_menu/data/repository/games_repository.dart';

final getIt = GetIt.instance;

void setUpServiceLocator() {
  getIt.registerSingleton<GamesRepository>(
    GamesRepository(
      baseGetCoinsRemoteDataSource: GamesRemoteDataSource(),
      baseMinusCoinsRemoteDataSource: GamesRemoteDataSource(),
    ),
  );
}
