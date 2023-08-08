import 'package:dio/dio.dart';

import '../utiles/constance/const_api.dart';

class DioHelper {
  static late Dio dio;

  static void init() {
    dio = Dio(BaseOptions(
      baseUrl: ApiConstant.baseUrl,
      receiveDataWhenStatusError: true,
    ));
  }

  static Future<Response> postData({
    required String endPoint,
    required String token,
    Map<String, dynamic>? data,
    Map<String, dynamic>? query,
  }) async {
    final options = Options(headers: {'Authorization': token});
    return await dio.post(endPoint,
        data: data, queryParameters: query, options: options);
  }

  static Future<Response> getData({
    required String endPoint,
    required String token,
    Map<String, dynamic>? data,
    Map<String, dynamic>? query,
  }) async {
    final options = Options(headers: {'Authorization': token});
    return await dio.get(
      '${ApiConstant.baseUrl}$endPoint',
      data: data,
      queryParameters: query,
      options: options,
    );
  }
}
