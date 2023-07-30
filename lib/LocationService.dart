import 'package:flutter/material.dart';
import 'package:location/location.dart';

class LocationService {
  Location location = Location();

  Stream<LocationData> getLocationStream() {
    return location.onLocationChanged;
  }
}

class GeoLocationScreen extends StatefulWidget {
  @override
  _GeoLocationScreenState createState() => _GeoLocationScreenState();
}

class _GeoLocationScreenState extends State<GeoLocationScreen> {
  bool _trackingEnabled = false;
  LocationService _locationService = LocationService();
  LocationData? _currentLocation;

  void _toggleTracking() async {
    if (_trackingEnabled) {
      _locationService.getLocationStream().listen((locationData) {
        setState(() {
          _currentLocation = locationData;
        });
      });
    } else {
      // доробити пілписку
      // _locationStreamSubscription.cancel();
    }

    setState(() {
      _trackingEnabled = !_trackingEnabled;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _trackingEnabled
                  ? 'Geolocation is turned on'
                  : 'Geolocation is turned off',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            Text(
              _currentLocation != null
                  ? 'Coordinates: ${_currentLocation!.latitude}, ${_currentLocation!.longitude}'
                  : 'Coordinates: -',
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _toggleTracking,
        child: Icon(
          _trackingEnabled ? Icons.pause : Icons.play_arrow,
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: GeoLocationScreen(),
  ));
}
