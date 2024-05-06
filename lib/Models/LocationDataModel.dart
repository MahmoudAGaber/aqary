import 'package:geocoding/geocoding.dart';


class LocationData {
  final double? longtude;
  final double? latitude;
  final Placemark? placemark;

  LocationData({
     this.longtude,
     this.latitude,
    this.placemark,
  });
}