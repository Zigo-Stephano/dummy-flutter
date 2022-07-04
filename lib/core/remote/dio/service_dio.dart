
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dummy_test/core/model/user.dart';

class ServiceDio {
  late Dio service;
  ServiceDio() {
    service = Dio();
    service.options = BaseOptions(
      baseUrl: "http://10.5.16.85/testing/",
      // baseUrl: "http://192.168.1.16/testing/"
    );
  }

  Future<User> deleteUser(int id) async {
    try {
      Map<String, dynamic> data = {};
      data['id'] = id;
      var result = await service.post(
        "delete_user.php",
        data: jsonEncode(data),
      );
      Map<String, dynamic> objResponse = jsonDecode(result.data);
      User user = User.fromJson(objResponse);
      return user;
    } catch (e) {
      print(e.toString());
      User user = User();
      return user;
    }
  }

  Future<User> addUser(String name, String email, String password) async {
    try {
      Map<String, dynamic> data = {};
      data['name'] = name;
      data['email'] = email;
      data['password'] = password;
      var result = await service.post(
        "register.php",
        data: jsonEncode(data),
      );
      Map<String, dynamic> objResponse = jsonDecode(result.data);
      User user = User.fromJson(objResponse);
      return user;
    } catch (e) {
      print(e.toString());
      User user = User();
      return user;
    }
  }

  Future<User> editUser(int id, String name, String email, String password) async {
    try {
      Map<String, dynamic> data = {};
      data['id'] = id;
      data['name'] = name;
      data['email'] = email;
      data['password'] = password;
      var result = await service.post(
        "edit_user.php",
        data: jsonEncode(data),
      );
      Map<String, dynamic> objResponse = jsonDecode(result.data);
      print(result.data);
      User user = User.fromJson(objResponse);
      return user;
    } catch (e) {
      print(e.toString());
      User user = User();
      return user;
    }
  }

  Future<User> userDio() async {
    try {
      var result = await service.get(
        "all_user.php"
      );
      Map<String, dynamic> objResponse = jsonDecode(result.data);
      User user = User.fromJson(objResponse);
      return user;
    } on Exception catch (e) {
      print(e.toString());
      User user = User();
      return user;
    }
  }
}