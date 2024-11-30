import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:logger/logger.dart';
import 'package:szakdolgozat_magantaxi_mobil/core/utils/service_locator.dart';

class ReviewService{
  final _dio = Dio(BaseOptions(
    baseUrl: 'http://10.0.2.2:8085/review',
    connectTimeout: const Duration(seconds: 5),
    receiveTimeout: const Duration(seconds: 5),
    headers: {
      'Content-Type': 'application/json',
      'accept': 'application/json',
      'Access-Control-Request-Headers': 'Origin',
      'Origin': 'mobileApp',
    },
  ));


  final _logger = Logger();

  ReviewService() {
    _dio.interceptors
        .add(InterceptorsWrapper(onRequest: (RequestOptions options, RequestInterceptorHandler handler) async {
      options.headers['cookie'] = 'token=${await getIt.get<FlutterSecureStorage>().read(key:'token')};';
      handler.next(options);
    }));
  }

  Future<bool> createReview({required double score, String? reviewText}) async{
    final resp = await _dio.post('/create',data: {'score':score,'reviewText':reviewText});
    _logger.d(resp.statusCode);
    return resp.statusCode == 200;
  }
}