import 'package:games/Features/games_menu/data/model/minus_coins_model.dart';

import '../../../../Core/error/exceptions.dart';
import '../../../../Core/helpers/dio_helper.dart';
import '../../../../Core/utiles/constance/const_api.dart';
import '../../domain/entites/get_coins/get_coins_entite.dart';
import '../../domain/entites/minus_coins/minus_coins_entity.dart';
import '../model/get_coins_model.dart';

abstract class BaseGamesRemoteDataSource {
  Future<GetCoinsEntity> getCoins();
  Future<MinusCoinsEntity> minusCoins({required int count});
}

class GamesRemoteDataSource extends BaseGamesRemoteDataSource {
  @override
  Future<GetCoinsEntity> getCoins() async {
    final response = await DioHelper.getData(
      endPoint: ApiConstant.getGetCoinsEndPoint,
      token: ApiConstant.token,
    );
    if (response.statusCode == 200) {
      print(response.data); //{coins: 1000, gems: 0}
      final jsonData = response.data;
      GetCoinsEntity getCoins = GetCoinsModel.fromJson(jsonData);

      return getCoins;
    } else {
      print('error +++++++++++++++++++');
      throw const ServerException(errorMessage: 'Error while get coins');
    }
  }

  @override
  Future<MinusCoinsEntity> minusCoins({required int count}) async {
    final response = await DioHelper.postData(
      endPoint: ApiConstant.minusCoinsEndPoint,
      token: ApiConstant.token,
      query: {
        ApiConstant.count: count,
      },
    );
    if (response.statusCode == 200) {
      print(response.data);
      final jsonData = response.data;
      MinusCoinsEntity getCoins = MinusCoinsModel.fromJson(jsonData);
      return getCoins;
    } else {
      print('error +++++++++++++++++++');
      throw const ServerException(errorMessage: 'Error while minus coins');
    }
  }
}
