import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:logger/logger.dart';
import 'package:szakdolgozat_magantaxi_mobil/main.dart';
import 'package:szakdolgozat_magantaxi_mobil/models/user.dart';
import 'package:szakdolgozat_magantaxi_mobil/routes/app_routes.dart';

import '../core/utils/service_locator.dart';

class UserService {
  final _dio = Dio(BaseOptions(
    baseUrl: 'http://10.0.2.2:8085/user',
    connectTimeout: const Duration(seconds: 5),
    receiveTimeout: const Duration(seconds: 5),
    headers: {
      'Content-Type': 'application/json',
      'accept': 'application/json',
      'Access-Control-Request-Headers': 'Origin',
      'Origin': 'mobileApp',
    },
    responseType: ResponseType.json,
  ));

  final _logger = Logger();

  UserService() {
    _dio.interceptors
        .add(InterceptorsWrapper(onRequest: (RequestOptions options, RequestInterceptorHandler handler) async {
      options.headers['cookie'] = 'token=${await getIt.get<FlutterSecureStorage>().read(key: 'token')};';
      handler.next(options);
    }));
    _dio.interceptors
        .add(InterceptorsWrapper(onResponse: (Response response, ResponseInterceptorHandler handler) {
      if (response.statusCode == 401) {
        navigatorKey.currentState?.pushReplacementNamed(AppRoutes.loginScreen);
        return;
      }
      handler.next(response);
    }));
  }

  Future<User> getOwnData() async {
    final resp = await _dio.get(
      '/getOwnData',
    );
    return User.fromJson(resp.data);
  }

  Future<bool> createPassenger(String email, String password, String name) async {
    try {
      final resp = await _dio.post('/signUpPassenger',
          data: {'email': email, 'password': password, 'name': name},
          options: Options(responseType: ResponseType.json));
      return resp.statusCode == 200;
    }catch (e){
      return false;
    }
  }

  Future<bool> logUserIn(String email, String password) async {
    final resp = await _dio.post(
      '/signInPassenger',
      data: {
        'email': email,
        'password': password,
      },
    );
    final token = resp.headers['set-cookie']![0].split(';')[0].split('=')[1];
    await getIt.get<FlutterSecureStorage>().write(key: 'token', value: token);
    return resp.statusCode == 200;
  }

  Future<bool> resetPassword(String email) async {
    final resp = await _dio.post(
      '/resetPassword',
      data: {
        'userEmail': email,
      },
    );
    if (resp.statusCode == 200) {
      return true;
    }
    return false;
  }

  Future<bool> checkToken() async {
    try {
      final resp = await _dio.get(
        '/checkToken',
      );
      return resp.statusCode == 200;
    } catch (e) {
      return false;
    }
  }

  Future<bool> logOut() async {
    try {
      final resp = await _dio.post(
        '/logOut',
      );
      return resp.statusCode == 200;
    } catch (e) {
      _logger.e(e);
      return false;
    }
  }

  Future<bool> changePassword({required String currentPassword, required String newPassword}) async {
    try {
      final resp = await _dio.post(
        '/changePassword',
        data: {
          'currentPass': currentPassword,
          'newPass': newPassword,
        },
      );
      return resp.statusCode == 200;
    } catch (e) {
      _logger.e(e);
      return false;
    }
  }

  Future<bool> changeName(String newName) async {
    try {
      final resp = await _dio.post(
        '/changeName',
        data: {
          'newName': newName,
        },
      );
      return resp.statusCode == 200;
    } catch (e) {
      _logger.e(e);
      return false;
    }
  }

  Future<bool> lockProfile() async {
    try {
      final resp = await _dio.post(
        '/lockProfile',
      );
      return resp.statusCode == 200;
    } catch (e) {
      _logger.e(e);
      return false;
    }
  }
}
