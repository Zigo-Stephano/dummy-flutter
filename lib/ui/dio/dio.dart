import 'package:dummy_test/controller/dio_controller.dart';
import 'package:dummy_test/core/model/user.dart';
import 'package:dummy_test/utils/dimension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DioView extends StatelessWidget {
  DioView({Key? key}) : super(key: key);
  final _controller = Get.put(DioController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("DIO"),
        actions: [
          IconButton(
            onPressed: (){
              Get.toNamed(
                "/add_dio", 
                arguments: User(
                  code: 303,
                ),
              );
            }, 
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Obx(
          () => _controller.isEmpty.isTrue ? Center(
          child: ElevatedButton(
            child: const Text("Get user"),
            onPressed: () {
               _controller.getUser();
            },
          ),
        ) : Padding(
          padding: EdgeInsets.all(Dimension.height10),
          child: ListView.builder(
            itemBuilder: ((context, index) {
              return ListTile(
                title: Text("${_controller.user.data![index].email}"),
                leading: Text("${_controller.user.data![index].name}"),
                subtitle: Text("${_controller.user.data![index].password}"),
                trailing: IconButton(
                  onPressed: (){
                    Get.defaultDialog(
                    title: "Peringatan",
                    middleText: "Anda yakin menghapus\nitem ini ?",
                    confirm: ElevatedButton(
                      onPressed: (){
                        _controller.deleteUser(int.parse(_controller.user.data![index].id.toString()));
                        Get.back();
                      }, 
                      child: const Text("Yes"),
                    ),
                    cancel: ElevatedButton(
                      onPressed: (){
                        Get.back();
                      }, 
                      child: const Text("No"),
                    ),
                    backgroundColor: Colors.lightBlue,
                    titleStyle: const TextStyle(color: Colors.white),
                    middleTextStyle: const TextStyle(color: Colors.white),
                    radius: 30
                  );
                  }, 
                  icon: const Icon(
                    Icons.delete,
                  ),
                ),
                onTap: (){
                  Get.toNamed(
                    "/add_dio",
                    arguments: User(
                      code: 302,
                      data: _controller.user.data,
                      message: _controller.user.data![index].id
                    ),
                  );
                },
                onLongPress: () {
                  Get.defaultDialog(
                    title: "Keterangan",
                    middleText: "Anda yakin melakukan edit pada\nitem ini ?",
                    confirm: ElevatedButton(
                      onPressed: (){
                        Get.back();
                        Get.toNamed(
                          "/add_dio",
                          arguments: User(
                            code: 301,
                            data: _controller.user.data,
                            message: _controller.user.data![index].id
                          ),
                        );
                      }, 
                      child: const Text("Yes"),
                    ),
                    cancel: ElevatedButton(
                      onPressed: (){
                        Get.back();
                      }, 
                      child: const Text("No"),
                    ),
                    backgroundColor: Colors.lightBlue,
                    titleStyle: const TextStyle(color: Colors.white),
                    middleTextStyle: const TextStyle(color: Colors.white),
                    radius: 30
                  );
                },
              );
            }),
            itemCount: _controller.user.data!.length,
          ),
        ),
      ),
    );
  }
}
