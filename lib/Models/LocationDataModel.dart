import 'package:geocoding/geocoding.dart';


class LocationData {
  final double longtude;
  final double latitude;
  final Placemark? placemark;

  LocationData({
    required this.longtude,
    required this.latitude,
    this.placemark,
  });
}