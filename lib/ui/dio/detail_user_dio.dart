import 'package:dummy_test/controller/dio_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/model/user.dart';

// ignore: must_be_immutable
class DetailDioView extends StatelessWidget {
  DetailDioView({Key? key}) : super(key: key);
  final _controller = Get.put(DioController());

  User data = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("User DIO"),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: TextField(
              readOnly: data.code == 302 ? true : false,
              controller: _controller.usernameC.value,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: 'User Name',
                hintText: data.code == 301 || data.code == 302 ? "${data.data![int.parse(data.message!)].name}" : "",
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: TextField(
              readOnly: data.code == 302 ? true : false,
              controller: _controller.emailC.value,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: 'Email',
                hintText: data.code == 301 || data.code == 302 ? "${data.data![int.parse(data.message!)].email}" : "",
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: TextField(
              readOnly: data.code == 302 ? true : false,
              obscureText: true,
              controller: _controller.passwordC.value,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: 'Password',
                hintText: data.code == 301 || data.code == 302 ? "${data.data![int.parse(data.message!)].password}" : "",
              ),
            ),
          ),
          Container(
            height: 50,
            width: double.maxFinite,
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: data.code == 302 ? const SizedBox(height: 0,) : ElevatedButton(
              child: data.code == 301 ? const Text('Edit User') : const Text('Add User'),
              // child: Text('$action User'),
              onPressed: () { 
                data.code == 301 ? _controller.editUserDio(int.parse(data.message!)) :  _controller.addUserDio();
              },
            ),
          ),
        ],
      ),
    );
  }
}