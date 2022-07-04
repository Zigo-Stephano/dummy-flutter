import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'dart:math';
import 'package:permission_handler/permission_handler.dart';

class AttendController extends GetxController {
  var address = 'Getting address..'.obs;
  RxBool isLoading = false.obs;
  final store = GetStorage();

  showLocation() {
    isLoading.value = true;
    requestPermission();
    isLoading.value = false;
  }

  void getLocation() async {
    var position = await Geolocator.getCurrentPosition();
    getAddress(position.latitude.toString(), position.longitude.toString());
  }

  Future<void> getAddress(String latitude, String longitude) async {
    if(store.read("attendLat") == null || store.read("attendLat") == null){
      Get.snackbar("Perhatian", "Please set attend location first");
    } else {
      String stringLat2 = store.read("attendLat").toString();
      String stringLong2 = store.read("attendLong").toString();
      num lat1 = num.parse(latitude);  
      num long1 = num.parse(longitude);  
      num lat2 = num.parse(stringLat2);  
      num long2 = num.parse(stringLong2);  
      double distance = calculateDistance(lat1, long1, lat2, long2);
      if(distance <= 0.05) {
        Get.snackbar("Perhatian", "Attend has been saved");
      } else {
        Get.snackbar("Perhatian", "Wrong location");
      }
    }
  }

  double calculateDistance(lat1, lon1, lat2, lon2){
    var p = 0.017453292519943295;
    var a = 0.5 - cos((lat2 - lat1) * p)/2 + 
          cos(lat1 * p) * cos(lat2 * p) * 
          (1 - cos((lon2 - lon1) * p))/2;
    return 12742 * asin(sqrt(a));
  }

  void requestPermission() async {
    var status = await Permission.location.status;
    if(status.isGranted) {
      getLocation();
    } else {
      await Permission.location.request();
    }
  }

}
