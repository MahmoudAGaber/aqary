import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../Models/LocationDataModel.dart';

final locationProvider = StateNotifierProvider<LocationNotifier, LocationData?>((ref) {
  return LocationNotifier(ref);
});


class LocationNotifier extends StateNotifier<LocationData?> {
  Ref ref;
  LocationNotifier(this.ref) : super(LocationData(longtude: 5.0, latitude: 0.0));

  GoogleMapController? _mapController;

  GoogleMapController? get mapController => _mapController;

  Future<void> getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
        localeIdentifier: 'ar'
      );

      LocationData locationData = LocationData(
        longtude: position.longitude,
        latitude:  position.latitude,
        placemark: placemarks.isNotEmpty ? placemarks.first : null,
      );

      state = locationData;


    } catch (e) {
      print(e);
      state = null;
    }
  }

  Future<void> changeCurrentLocation(LatLng point) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        point.latitude,
        point.longitude,
          localeIdentifier: 'ar'
      );

      if (placemarks.isNotEmpty) {
        state = LocationData(
          latitude: point.latitude,
          longtude: point.longitude,
          placemark: placemarks.first,

        );
      }
    } catch (e) {
      print("Error getting address: $e");
    }
  }

  void onMapCreated(GoogleMapController controller) {
    _mapController = controller;
  }

  void onTap(LatLng point) async {
    await changeCurrentLocation(point);
  }

  void onDonePressed() {
    // Perform any action needed when the user presses "Done"
    print("Selected Location: ${state?.longtude}");
    print("Selected Address: ${state?.placemark!.name}");
  }
}




