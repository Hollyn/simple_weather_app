import 'package:geolocator/geolocator.dart';

class Location {
  late double longitude;
  late double latitude;
  late Position position;

  Future<void> getCurrentLocation() async {
    try {
      var permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          // Permissions are denied, next time you could try
          // requesting permissions again (this is also where
          // Android's shouldShowRequestPermissionRationale
          // returned true. According to Android guidelines
          // your App should show an explanatory UI now.
          return Future.error('Location permissions are denied');
        }
      } else {
        position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.low);
        longitude = position.longitude;
        latitude = position.latitude;
      }
    } catch (e) {
      print(e);
    }
  }
}
