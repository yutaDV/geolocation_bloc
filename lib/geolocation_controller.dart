import 'dart:async';
import 'package:geolocator/geolocator.dart';

class GeolocationController {
  StreamController<Position> _positionStreamController = StreamController<Position>();
  Stream<Position> get positionStream => _positionStreamController.stream;

  void dispose() {
    _positionStreamController.close();
  }

  void startTracking({LocationAccuracy desiredAccuracy = LocationAccuracy.best}) {
    _getCurrentLocation(desiredAccuracy);
  }

  Future<void> _getCurrentLocation(LocationAccuracy desiredAccuracy) async {
    while (true) {
      try {
        Position position = await determinePosition(desiredAccuracy);
        _positionStreamController.add(position);
      } catch (e) {
        print('Error getting location: $e');
      }
      await Future.delayed(Duration(seconds: 1));
    }
  }

  Future<Position> determinePosition(LocationAccuracy desiredAccuracy) async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception('Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition(desiredAccuracy: desiredAccuracy);
  }
}
