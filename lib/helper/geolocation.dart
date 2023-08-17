import 'package:geolocator/geolocator.dart';

class GeoLocationHelper {
  bool checkifWithinRadius(
      {required double centerLat,
      required double centerLng,
      required double targetLat,
      required double targetLng}) {
    double distanceInMeters =
        Geolocator.distanceBetween(centerLat, centerLng, targetLat, targetLng);
    if (distanceInMeters <= 50) {
      return true;
    }

    return false;
  }
}
