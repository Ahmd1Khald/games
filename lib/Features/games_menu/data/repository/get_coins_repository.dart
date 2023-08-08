import 'package:dartz/dartz.dart';
import 'package:games/Features/games_menu/domain/entites/get_coins/get_coins_entite.dart';

import '../../../../Core/error/exceptions.dart';
import '../../../../Core/error/failure.dart';
import '../../domain/repository/base_games_repository.dart';
import '../data_sources/get_coins_remote_data_source.dart';

class GetCoinsRepository extends BaseGamesRepository {
  final BaseGetCoinsRemoteDataSource baseGetCoinsRemoteDataSource;

  GetCoinsRepository({
    required this.baseGetCoinsRemoteDataSource,
  });

  @override
  Future<Either<Failure, GetCoinsEntity>> fetchListGetCoins() async {
    try {
      final result = await baseGetCoinsRemoteDataSource.getCoins();
      //print(result);
      return Right(result);
    } on ServerException catch (failure) {
      print('failure  +++++++++++++++++++');
      print(failure);
      return Left(ServerFailure(failure.errorMessage));
    }
  }
}
