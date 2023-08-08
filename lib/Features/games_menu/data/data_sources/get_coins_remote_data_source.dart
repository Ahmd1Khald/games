import '../../../../Core/error/exceptions.dart';
import '../../../../Core/helpers/dio_helper.dart';
import '../../../../Core/utiles/constance/const_api.dart';
import '../../domain/entites/get_coins/get_coins_entite.dart';
import '../model/get_coins_model.dart';

abstract class BaseGetCoinsRemoteDataSource {
  Future<List<GetCoinsEntity>> getCoins();
}

class GetCoinsRemoteDataSource extends BaseGetCoinsRemoteDataSource {
  @override
  Future<List<GetCoinsEntity>> getCoins() async {
    final response = await DioHelper.getData(
      endPoint: ApiConstant.getGetCoinsEndPoint,
      token: ApiConstant.token,
    );
    if (response.statusCode == 200) {
      print(response.data);
      final jsonData = response.data as List<dynamic>;
      List<GetCoinsEntity> getCoins =
          jsonData.map((e) => GetCoinsModel.fromJson(e)).toList();

      return getCoins;
    } else {
      print('error +++++++++++++++++++');
      throw const ServerException(errorMessage: 'Error while get coins');
    }
  }
}
