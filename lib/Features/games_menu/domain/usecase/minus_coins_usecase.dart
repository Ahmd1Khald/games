import 'package:dartz/dartz.dart';

import '../../../../Core/error/failure.dart';
import '../../../../Core/services/use_cases.dart';
import '../entites/minus_coins/minus_coins_entity.dart';
import '../repository/base_games_repository.dart';

class MinusCoinsUseCase extends UseCase<MinusCoinsEntity, int> {
  final BaseGamesRepository baseGamesRepository;

  MinusCoinsUseCase(this.baseGamesRepository);

  @override
  Future<Either<Failure, MinusCoinsEntity>> execute(int param) async {
    return await baseGamesRepository.minusCoins(count: param);
  }
}
