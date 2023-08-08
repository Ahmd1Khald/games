import 'package:get_it/get_it.dart';

import '../../Features/games_menu/data/data_sources/get_coins_remote_data_source.dart';
import '../../Features/games_menu/data/repository/get_coins_repository.dart';

final getIt = GetIt.instance;

void setUpServiceLocator() {
  getIt.registerSingleton<GetCoinsRepository>(
    GetCoinsRepository(
      baseGetCoinsRemoteDataSource: GetCoinsRemoteDataSource(),
    ),
  );
}
