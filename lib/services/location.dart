import 'package:geolocator/geolocator.dart';

class LocationBrain {
  double? lat;
  double? lng;

  Future<void> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
    }

    var pos =  await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.low);
    lat = pos.latitude.toDouble();
    lng = pos.longitude.toDouble();
  }
}
