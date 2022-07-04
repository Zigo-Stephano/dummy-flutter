import 'ui/assets/assets.dart';
import 'ui/dio/detail_user_dio.dart';
import 'ui/dio/dio.dart';
import 'ui/tracking/tracking.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'ui/attend/open_map.dart';
import 'ui/home/home.dart';
import 'ui/login/login.dart';
import 'ui/splash/splash.dart';
import 'ui/attend/attendance.dart';

void main() async{
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: "/",
      getPages: [
        GetPage(name: "/", page: () => const SplashScreen()),
        GetPage(name: "/login", page: () => LoginView()),
        GetPage(name: "/attendance", page: () => AttendanceView()),
        GetPage(name: "/tracking", page: () => const TrackingView()),
        GetPage(name: "/assets", page: () => const AsstesView()),
        GetPage(name: "/home", page: () => const HomeView()),
        GetPage(name: "/dio", page: () => DioView()),
        GetPage(name: "/add_dio", page: () => DetailDioView()),
        GetPage(name: "/open_map", page: () => const OpenMapView()),
      ],
      debugShowCheckedModeBanner: false,
      title: 'Demo Test',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}
