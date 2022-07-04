import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/utils/dimension.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
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
                        Get.toNamed("/attendance");
                      },
                      child: Text(
                        "Attendance",
                        style: TextStyle(
                          fontSize: Dimension.font15,
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.directions_walk,
                      size: 48,
                      color: Colors.blue,
                    ),
                    SizedBox(
                      height: Dimension.height15,
                    ),
                    ElevatedButton(
                      onPressed: (){
                        Get.toNamed("/tracking");
                      },
                      child: Text(
                        "Tracking",
                        style: TextStyle(
                          fontSize: Dimension.font15,
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.inventory,
                      size: 48,
                      color: Colors.blue,
                    ),
                    SizedBox(
                      height: Dimension.height15,
                    ),
                    ElevatedButton(
                      onPressed: (){
                        Get.toNamed("/assets");
                      },
                      child: Text(
                        "Assets",
                        style: TextStyle(
                          fontSize: Dimension.font15,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.computer,
                      size: 48,
                      color: Colors.blue,
                    ),
                    SizedBox(
                      height: Dimension.height15,
                    ),
                    ElevatedButton(
                      onPressed: (){
                        Get.toNamed("/dio");
                      },
                      child: Text(
                        "DIO",
                        style: TextStyle(
                          fontSize: Dimension.font15,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}