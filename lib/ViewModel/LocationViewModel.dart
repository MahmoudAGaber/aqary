import 'package:aqary/data/RequestHandler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../Models/LocationDataModel.dart';

final estatelocationProvider = StateNotifierProvider<EstateLocationNotifier, LocationData?>((ref) {
  return EstateLocationNotifier(ref);
});

final userLocationProvider = StateNotifierProvider<UserLocationNotifier, LocationData?>((ref) {
  return UserLocationNotifier(ref);
});

final usreChangeLocationProvider = StateProvider<String>((ref) => "");

//final estateAddressProvider = StateNotifierProvider<EstateLocationNotifier,LocationData>((ref) => EstateLocationNotifier(ref));

// class EstateAddressNotifier extends StateNotifier<LocationData> {
//   Ref ref;
//   EstateAddressNotifier(this.ref):super(LocationData());
//
//   void setEstateAddress(address){
//     state = address;
//   }
// }

class EstateLocationNotifier extends StateNotifier<LocationData?> {
  Ref ref;
  EstateLocationNotifier(this.ref) : super(LocationData(longtude: 5.0, latitude: 0.0));

  GoogleMapController? _mapController;

  GoogleMapController? get mapController => _mapController;

  Future<LocationData> getCurrentEstateLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
        localeIdentifier: 'ar-SA'
      );
     placemarks.forEach((element) {print(element.subAdministrativeArea);});

      LocationData locationData = LocationData(
        longtude: position.longitude,
        latitude:  position.latitude,
        placemark: placemarks.isNotEmpty ? placemarks[3] : null,
      );

      state = locationData;

      return state!;
    } catch (e) {
      print(e);
      state = null;
    }
    return state!;
  }

  Future<void> changeCurrentEstateLocation(LatLng point) async {
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
          placemark: placemarks[3],

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
    await changeCurrentEstateLocation(point);
  }

  void onDonePressed() {
    // Perform any action needed when the user presses "Done"
    print("Selected Location: ${state?.longtude}");
    print("Selected Address: ${state?.placemark!.name}");
  }
}

class UserLocationNotifier extends StateNotifier<LocationData?> {
  Ref ref;
  UserLocationNotifier(this.ref) : super(LocationData(longtude: 5.0, latitude: 0.0));

  RequestHandler requestHandler = RequestHandler();
  GoogleMapController? _mapController;

  GoogleMapController? get mapController => _mapController;

  Future<LocationData> getCurrentUserLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      List<Placemark> placemarks = await placemarkFromCoordinates(
          position.latitude,
          position.longitude,
          localeIdentifier: 'ar-SA'
      );
      placemarks.forEach((element) {print(element.subAdministrativeArea);});

      LocationData locationData = LocationData(
        longtude: position.longitude,
        latitude:  position.latitude,
        placemark: placemarks.isNotEmpty ? placemarks[3] : null,
      );

      state = locationData;
      print("OKDKD${state!.longtude} ${state!.latitude}");

      return state!;
    } catch (e) {
      print(e);
      state = null;
    }
    return state!;
  }

  Future<void> changeCurrentUserLocation(LatLng point) async {
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
          placemark: placemarks[3],

        );
        var city = "${state!.placemark!.country}, ${state!.placemark!.locality}, ${state!.placemark!.administrativeArea}";
        ref.read(usreChangeLocationProvider.notifier).state = city;
        await requestHandler.getData(
          endPoint: "/countries/change/$city",
          auth: true, fromJson: (json) {  },
        );
      }
    } catch (e) {
      print("Error getting address: $e");
    }
  }
}











