import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:get/get.dart';


class OpenMapView extends StatefulWidget {
  const OpenMapView({Key? key}) : super(key: key);

  @override
  State<OpenMapView> createState() => OpenMapState();
}

class OpenMapState extends State<OpenMapView> {
  final Completer<GoogleMapController> _controller = Completer();
  LatLng position = const LatLng(0, 0);
  final store = GetStorage();


  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(-6.215615248420082, 106.83718343902656),
    zoom: 14,
  );

  @override
  Widget build(BuildContext context) {
    // ignore: unnecessary_new
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            mapType: MapType.terrain,
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            initialCameraPosition: _kGooglePlex,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
            onCameraMove: (e) {
              setState(() {
                position = e.target;
              });
            },
          ),
          const Center(
            child: Icon(
              Icons.location_on,
              size: 60,
              color: Colors.blue,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: ElevatedButton(
              onPressed: ()=> showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: const Text('This location will be attend location'),
                  content: const Text('Are you sure ?'),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.pop(context, 'Cancel'),
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () { 
                        store.write("attendLat", position.latitude);
                        store.write("attendLong", position.longitude);
                        Navigator.pop(context, 'OK');
                        Get.back();
                      },
                      child: const Text('OK'),
                    ),
                  ],
                ),
              ),
              child: const Text("Save location"),
            ),
          ),
        ],
      ),
    );
  }
}