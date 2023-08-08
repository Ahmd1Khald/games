import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:games/Features/games_menu/domain/entites/get_coins/get_coins_entite.dart';
import 'package:games/Features/games_menu/domain/entites/minus_coins/minus_coins_entity.dart';

import '../../../../Core/error/exceptions.dart';
import '../../../../Core/error/failure.dart';
import '../../domain/repository/base_games_repository.dart';
import '../data_sources/games_remote_data_source.dart';

class GamesRepository extends BaseGamesRepository {
  final BaseGamesRemoteDataSource baseGetCoinsRemoteDataSource;
  final BaseGamesRemoteDataSource baseMinusCoinsRemoteDataSource;

  GamesRepository({
    required this.baseMinusCoinsRemoteDataSource,
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

  @override
  Future<Either<Failure, MinusCoinsEntity>> minusCoins(
      {required int count}) async {
    try {
      // final localResult = await baseVideosLocalDataSource.getItemsList();
      // if (localResult.isNotEmpty) {
      //   return Right(localResult);
      // }
      final result =
          await baseMinusCoinsRemoteDataSource.minusCoins(count: count);
      print(result);
      return Right(result);
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionError &&
          e.error is SocketException) {
        return left(const ServerFailure('No network connection'));
      }
    }
    return left(const ServerFailure('Error when get items repo'));
  }
}
