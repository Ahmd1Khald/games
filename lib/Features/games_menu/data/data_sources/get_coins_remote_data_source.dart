import '../../../../Core/error/exceptions.dart';
import '../../../../Core/helpers/dio_helper.dart';
import '../../../../Core/utiles/constance/const_api.dart';
import '../../domain/entites/get_coins/get_coins_entite.dart';
import '../model/get_coins_model.dart';

abstract class BaseGetCoinsRemoteDataSource {
  Future<GetCoinsEntity> getCoins();
}

class GetCoinsRemoteDataSource extends BaseGetCoinsRemoteDataSource {
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
}
