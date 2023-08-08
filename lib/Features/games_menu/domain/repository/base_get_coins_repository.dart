import 'package:dartz/dartz.dart';

import '../../../../Core/error/failure.dart';
import '../entites/get_coins/get_coins_entite.dart';

abstract class BaseGetCoinsRepository {
  Future<Either<Failure, List<GetCoinsEntity>>> fetchListGetCoins();
}
