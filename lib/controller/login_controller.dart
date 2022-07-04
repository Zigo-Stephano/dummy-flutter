import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final Rx<TextEditingController> nameController = TextEditingController().obs;
  final Rx<TextEditingController> passwordController = TextEditingController().obs;


  Future<void> login() async {
    String username = nameController.value.text;
    String password = passwordController.value.text;
    if(username == "" || password == "") {
      Get.snackbar("Perhatian", "Username dan password harus diisi, periksa kembali");
    } else if (username == "hazi" && password == "123" ) {
      Get.offAllNamed("/home");
    } else {
      Get.snackbar("Perhatian", "Ada kesalahan pada username atau password salah\nPeriksa kembali");
    }
  }
}