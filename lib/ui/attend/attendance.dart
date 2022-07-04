import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/attend_controller.dart';
import '../../utils/dimension.dart';

class AttendanceView extends StatelessWidget {
  AttendanceView({Key? key}) : super(key: key);
  final _controller = Get.put(AttendController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Attendance"),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: () {
                Get.toNamed("/open_map");
              },
              child: const Icon(
                Icons.location_on,
                size: 26.0,
              ),
            ),
          ), 
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(
              Icons.location_on,
              size: 48,
              color: Colors.blue,
            ),
            SizedBox(
              height: Dimension.height15,
            ),
            ElevatedButton(
              onPressed: (){
                _controller.showLocation();
              },
              child: Obx(
                () => Text(
                  _controller.isLoading.value ? "Loading.." : "Get Attend",
                  style: TextStyle(
                    fontSize: Dimension.font15,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}