import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'geolocation_controller.dart';

class GeolocationScreen extends StatefulWidget {
  @override
  _GeolocationScreenState createState() => _GeolocationScreenState();
}

class _GeolocationScreenState extends State<GeolocationScreen> {
  GeolocationController _geolocationController = GeolocationController();
  Position? _currentPosition;
  bool _isTracking = false;

  @override
  void dispose() {
    _geolocationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Geolocation Tracker'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                _toggleTracking();
              },
              child: Text(_isTracking ? 'Stop Tracking' : 'Start Tracking'),
            ),
            SizedBox(height: 20),
            StreamBuilder<Position>(
              stream: _geolocationController.positionStream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  Position position = snapshot.data!;
                  return Text('Latitude: ${position.latitude}, Longitude: ${position.longitude}');
                } else if (snapshot.hasError) {
                  return Text('Error getting location: ${snapshot.error}');
                } else {
                  return Text('Location data not available');
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  void _toggleTracking() {
    if (_isTracking) {
      _stopTracking();
    } else {
      _startTracking();
    }
  }

  void _startTracking() {
    setState(() {
      _isTracking = true;
    });

    _geolocationController.startTracking(desiredAccuracy: LocationAccuracy.best);
  }

  void _stopTracking() {
    setState(() {
      _isTracking = false;
    });
  }
}
