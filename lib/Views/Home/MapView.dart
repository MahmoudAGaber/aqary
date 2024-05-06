


import 'dart:async';
import 'dart:typed_data';

import 'package:aqary/Models/LocationDataModel.dart';
import 'package:aqary/Views/HomePage.dart';
import 'package:aqary/Views/base/custom_app_bar.dart';
import 'package:aqary/Views/base/custom_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../ViewModel/CategoryViewModel.dart';
import '../../ViewModel/LocationViewModel.dart';

class MapView extends ConsumerStatefulWidget {
  String title;
  bool isSelected;
  bool isUserLocation;
  LatLng lat;
  MapView({super.key,required this.lat,required this.title,required this.isSelected,required this.isUserLocation});

  @override
  ConsumerState<MapView> createState() => _MapViewState();
}

class _MapViewState extends ConsumerState<MapView> {

  final Completer<GoogleMapController> _controller = Completer<GoogleMapController>();

   List<Marker>? markers;
    CameraPosition? kGooglePlex;
    String? estateAddress;

   @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
     // var currentLocation = ref.watch(locationProvider)

    });
    kGooglePlex = CameraPosition(target: widget.lat,zoom: 14);
    markers = [
      Marker(markerId: MarkerId("1"),
        position:  widget.lat,
        consumeTapEvents: true,
        infoWindow: InfoWindow(title: "Me"),

      )
    ];
    super.initState();
  }





  @override
  Widget build(BuildContext context) {
    var estateAddressSelected = ref.watch(estatelocationProvider);
    var addressSelected = ref.watch(userLocationProvider);
    if(widget.isUserLocation){
      estateAddress = "${addressSelected!.placemark!.country}, ${addressSelected!.placemark!.administrativeArea}, ${addressSelected!.placemark!.street}";

    }else{
      estateAddress = "${estateAddressSelected!.placemark!.country}, ${estateAddressSelected!.placemark!.administrativeArea}, ${estateAddressSelected!.placemark!.street}";

    }
    return Scaffold(
      appBar: CustomAppBar(
        title: widget.title,),
      body: Stack(
        children: [
          kGooglePlex == null || markers == null
              ? Center(child: CircularProgressIndicator(color: Theme.of(context).primaryColor,))
              :GoogleMap(
            trafficEnabled: true,
            myLocationEnabled: true,
            initialCameraPosition: kGooglePlex!,
            onTap: (cameraPosition)async{
              if(widget.isUserLocation){
                setState(() {
                  ref.read(userLocationProvider.notifier).changeCurrentUserLocation(cameraPosition);
                  markers = [
                    Marker(markerId: MarkerId("1"),
                      position: LatLng(cameraPosition.latitude, cameraPosition.longitude),)];
                });

              }
              else{
                if(widget.isSelected) {
                  ref.read(estatelocationProvider.notifier).changeCurrentEstateLocation(cameraPosition);
                  markers = [
                    Marker(markerId: MarkerId("2"),
                      position: LatLng(
                          cameraPosition.latitude, cameraPosition.longitude),),
                  ];
                }
              }

            },
            compassEnabled: true,
            mapToolbarEnabled: true,
            myLocationButtonEnabled: true,
            mapType: MapType.normal,
            markers: Set<Marker>.of(markers!),
            onMapCreated: (GoogleMapController controller){
              _controller.complete(controller);
            },
          ),
         widget.isSelected
             ? Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 150,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: (
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(estateAddress!,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 16),textAlign: TextAlign.center,),
                    CustomButton(
                        buttonText: "تأكيد الموقع",
                        textColor: Colors.white,
                        onPressed: (){
                          if(widget.isUserLocation){
                            ref.read(userLocationProvider.notifier).changeCurrentUserLocation(LatLng(addressSelected!.latitude!, addressSelected.longtude!));
                          }else{
                            ref.read(estatelocationProvider.notifier).changeCurrentEstateLocation(LatLng(estateAddressSelected!.latitude!, estateAddressSelected.longtude!));

                          }
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>Homepage(page: 0)));
                    })
                  ],
                )
                ),
              ),
            ),
          )
             : SizedBox()
        ],
      )
    );
  }
}

class MyCustomMarkerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
