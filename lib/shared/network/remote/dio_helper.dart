import 'package:dio/dio.dart';
class DioHelper{
  static Dio ? dio1 ;
  static Dio ? dio2 ;
  static void init() {
    dio1 = Dio(
      BaseOptions(
        baseUrl: 'https://rapitorder.pythonanywhere.com/customer/',
        receiveDataWhenStatusError: true,
      ),
    );
    dio2 = Dio(
      BaseOptions(
        baseUrl: 'https://favoritefoodapi.p.rapidapi.com',
        receiveDataWhenStatusError: true,
      ),
    );
  }
  static Future<Response?> getFavoriteFoodData({
    required String url,
    required Map<String, dynamic> query,
  }) async {
    dio2?.options.baseUrl = 'https://favoritefoodapi.p.rapidapi.com';
    dio2?.options.headers = {
      'X-RapidAPI-Key': '079fc6305emsh023fcbc804f30f7p1671b3jsnb39926bee9fb',
      // Add any other headers required by the Favorite Food API
    };
    return await dio2?.get(url, queryParameters: query);
  }

  static Future<Response?> getData({
    required String url,
    Map<String,dynamic> ? query,
  })async{
    dio1?.options.baseUrl = 'https://rapitorder.pythonanywhere.com';
    return await dio1?.get(
      url,
      queryParameters: query,
    );
  }

  static Future<Response?> postData({
    required String url,
    required Map<String,dynamic> data,
    Map<String,dynamic> ? query,
  })async{
    dio1?.options.baseUrl = 'https://rapitorder.pythonanywhere.com';
    return await dio1?.post(
      url,
      queryParameters: query,
      data: data,
    );
  }

}