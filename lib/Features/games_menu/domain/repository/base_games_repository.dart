import 'package:dartz/dartz.dart';

import '../../../../Core/error/failure.dart';
import '../entites/get_coins/get_coins_entite.dart';
import '../entites/minus_coins/minus_coins_entity.dart';

abstract class BaseGamesRepository {
  Future<Either<Failure, GetCoinsEntity>> fetchListGetCoins();
  Future<Either<Failure, MinusCoinsEntity>> minusCoins({required int count});
}
