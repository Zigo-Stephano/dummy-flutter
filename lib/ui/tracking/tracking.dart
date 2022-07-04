import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class TrackingView extends StatefulWidget {
  const TrackingView({Key? key}) : super(key: key);

  @override
  State<TrackingView> createState() => _TrackingViewState();
}

class _TrackingViewState extends State<TrackingView> {

  final Completer<GoogleMapController> _controller = Completer();

  static const source = LatLng(-6.198590040409831, 106.83240630990011);
  static const destination = LatLng(-6.1723309733449705, 106.82301993086152);

  List<LatLng> polylineCoordinates = [];

  void getPolyPoint() async {
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      "AIzaSyCcxyzjH-PCW-Hf8_h4-0jPueABP0mSDhM", 
      PointLatLng(source.latitude, source.longitude), 
      PointLatLng(destination.latitude, destination.longitude), 
    );

    if(result.points.isNotEmpty) {
      print("point : ${result.status}, ${result.points}, ${result.errorMessage}");
      for (var point in result.points) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      }
      setState(() {
        polylineCoordinates;
      });
    } else {
      print("point : ${result.status}, ${result.points}, ${result.errorMessage}");
    }
  }

  @override
  void initState() {
    getPolyPoint();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tracking"),
      ),
      body: GoogleMap(
        initialCameraPosition: const CameraPosition(
          target: source,
          zoom: 13
        ),
        polylines: {
          Polyline(
            polylineId: PolylineId("route"),
            points: polylineCoordinates,
            color: Colors.blue,
          ),
        },
        markers: {
          const Marker(
            markerId: MarkerId("source"),
            position: source
          ),
          const Marker(
            markerId: MarkerId("destination"),
            position: destination
          ),
        },
      ),
    );
  }
}