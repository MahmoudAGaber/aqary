


import 'dart:async';
import 'dart:typed_data';

import 'package:aqary/Models/LocationDataModel.dart';
import 'package:aqary/Views/base/custom_app_bar.dart';
import 'package:aqary/Views/base/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../ViewModel/LocationViewModel.dart';

class MapView extends ConsumerStatefulWidget {

  MapView({super.key});

  @override
  ConsumerState<MapView> createState() => _MapViewState();
}

class _MapViewState extends ConsumerState<MapView> {

  final Completer<GoogleMapController> _controller = Completer<GoogleMapController>();

   List<Marker> markers = [
    Marker(markerId: MarkerId("1"),
        consumeTapEvents: true,
    infoWindow: InfoWindow(title: "Me"),

    )
  ];
   


  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(25.1937, 55.2666),
    zoom: 14.3,
  );


  @override
  Widget build(BuildContext context) {
    var addressSelected = ref.watch(locationProvider);
    return Scaffold(
      appBar: CustomAppBar(
        title: "حدد موقعك",),
      body: GoogleMap(
        trafficEnabled: true,
        myLocationEnabled: true,
        initialCameraPosition: _kGooglePlex ,
        onTap: (cameraPosition)async{
          ref.read(locationProvider.notifier).changeCurrentLocation(cameraPosition);
         markers = [Marker(markerId: MarkerId("1"),position: LatLng(cameraPosition.latitude, cameraPosition.longitude),),];

        },
        compassEnabled: true,
        mapToolbarEnabled: true,
        myLocationButtonEnabled: true,
        mapType: MapType.normal,
        markers: Set<Marker>.of(markers),
        onMapCreated: (GoogleMapController controller){
          _controller.complete(controller);
        },
      )
    );
  }
}

class MyCustomMarkerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Your custom marker widget design goes here
    return Container(
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Icon(
        Icons.location_on,
        color: Colors.white,
        size: 30.0,
      ),
    );
  }
}
