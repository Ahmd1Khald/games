import 'package:dartz/dartz.dart';

import '../../../../Core/error/failure.dart';
import '../../../../Core/services/use_cases.dart';
import '../entites/get_coins/get_coins_entite.dart';
import '../repository/base_games_repository.dart';

class GetCoinsUseCase extends UseCase<GetCoinsEntity, NoParam> {
  final BaseGamesRepository baseGetCoinsRepository;

  GetCoinsUseCase(this.baseGetCoinsRepository);

  @override
  Future<Either<Failure, GetCoinsEntity>> execute([NoParam? param]) async {
    return await baseGetCoinsRepository.fetchListGetCoins();
  }
}
