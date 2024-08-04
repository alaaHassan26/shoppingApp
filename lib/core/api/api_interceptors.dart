import 'package:dio/dio.dart';
import 'package:shoping/cache/cache_helper.dart';
import 'package:shoping/core/api/end_ponits.dart';

class ApiInterceptor extends Interceptor {
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final token = await CacheHelper().getData(key: ApiKey.token);
    final lang = await CacheHelper().getData(key: 'lang') ?? 'en';
    if (token != null) {
      options.headers['Authorization'] = token;
    }
    options.headers['lang'] = lang;
    super.onRequest(options, handler);
  }
}

// import 'package:dio/dio.dart';
// import 'package:shoping/cache/cache_helper.dart';
// import 'package:shoping/core/api/end_ponits.dart';

// class ApiInterceptor extends Interceptor {
//   @override
//   void onRequest(
//       RequestOptions options, RequestInterceptorHandler handler) async {
//     final token = await CacheHelper().getData(key: ApiKey.token);
//     final lang = await CacheHelper().getData(key: 'lang') ?? 'en';
//     if (token != null) {
//       options.headers['Authorization'] = token;
//     }
//     options.headers['lang'] = lang;
//     super.onRequest(options, handler);
//   }
// }
