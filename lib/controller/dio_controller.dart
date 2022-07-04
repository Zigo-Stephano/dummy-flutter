import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../core/model/user.dart';
import '../core/remote/dio/service_dio.dart';

class DioController extends GetxController {

  Rx<TextEditingController> usernameC = TextEditingController().obs;
  Rx<TextEditingController> emailC = TextEditingController().obs;
  Rx<TextEditingController> passwordC = TextEditingController().obs;

  User user = User();
  RxBool isEmpty = true.obs;
  var service = ServiceDio();

  Future addUserDio() async {
    var user = usernameC.value.text;
    var email = emailC.value.text;
    var password = passwordC.value.text;
    if(user == "" || email == "" || password == "") {
      Get.snackbar("Kesalahan", "Username, email dan password harus diisi");
    } else {
      var response = await service.addUser(user, email, password);
      if(response.code == 200) {
        Get.back();
        isEmpty.value = true;
        usernameC.value.text = "";
        emailC.value.text = "";
        passwordC.value.text = "";
        Get.snackbar("Berhasil", response.message.toString());
      } else {
        Get.snackbar("Kesalahan", response.message.toString());
      }
    }
  }

  Future<void> getUser() async {
    var response = await service.userDio();
    user = response;
    isEmpty.value = false;
  }

  Future<void> deleteUser(int id) async {
    var response = await service.deleteUser(id);
    if(response.code == 200) {
      Get.snackbar("Berhasil", response.message.toString());
      isEmpty.value = true;
    } else {
      Get.snackbar("Kesalahan", response.message.toString());
    }
  }

  Future<void> editUserDio(int id) async {
    var user = usernameC.value.text;
    var email = emailC.value.text;
    var password = passwordC.value.text;
    if(user == "" || email == "" || password == "") {
      Get.snackbar("Kesalahan", "Username, email dan password harus diisi");
    } else {
      var response = await service.editUser(id, user, email, password);
      if(response.code == 200) {
        Get.back();
        isEmpty.value = true;
        usernameC.value.text = "";
        emailC.value.text = "";
        passwordC.value.text = "";
        Get.snackbar("Berhasil", response.message.toString());
      } else {
        Get.snackbar("Kesalahan", response.message.toString());
      }
    }
  }
}