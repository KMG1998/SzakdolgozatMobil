import 'dart:ffi';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:szakdolgozat_magantaxi_mobil/models/DriverLocation.dart';
import 'package:szakdolgozat_magantaxi_mobil/models/User.dart';

class UserService {
  final dio = Dio(BaseOptions(
      baseUrl: 'http://10.0.2.2:8085/user',
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 3)));
  User? currentUser;

  static final UserService _singleton = UserService._internal();

  factory UserService() {
    return _singleton;
  }

  UserService._internal();

  Future<User> getUser(
      String uid) async {
    var resp = await dio.get('',
        data: {'userId': uid},
        options: Options(responseType: ResponseType.json, headers: {
          'Access-Control-Allow-Origin': '*',
          'Content-Type': 'application/json',
          'accept': 'application/json'
        }));
    return User.fromJson(resp.data as Map<String, dynamic>);
  }

  Future<User> createPassenger(
      String email, String password, String name) async {
    var resp = await dio.post('/create',
        data: {'email': email, 'password': password, 'name': name, 'type': '5'},
        options: Options(responseType: ResponseType.json, headers: {
          'Access-Control-Allow-Origin': '*',
          'Content-Type': 'application/json',
          'accept': 'application/json'
        }));
    return User.fromJson(resp.data as Map<String, dynamic>);
  }

  Future<User> logUserIn(String email, String password) async {
    var resp = await dio.post('/signIn',
        data: {
          'email': email,
          'password': password,
        },
        options: Options(responseType: ResponseType.json, headers: {
          'Access-Control-Allow-Origin': '*',
          'Content-Type': 'application/json',
          'accept': 'application/json'
        }));
    currentUser = User.fromJson(resp.data as Map<String, dynamic>);
    return currentUser!;
  }

  Future<DriverLocation> getDriver(double lat, double longit) async {
    var resp = await dio.get('/getDriver',
        data: {
          'lat':lat,
          'long':longit,
        },
        options: Options(responseType: ResponseType.json, headers: {
          'Access-Control-Allow-Origin': '*',
          'Content-Type': 'application/json',
          'accept': 'application/json'
        }));
    debugPrint(resp.data.toString());
    DriverLocation randomDriver = DriverLocation.fromJson(resp.data as Map<String, dynamic>);
    return randomDriver;
  }


}
