import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import 'geolocation_service.dart';

class GeolocationScreen extends StatefulWidget {
  final GeolocationService geolocationService; // Додайте поле для сервісу

  GeolocationScreen({required this.geolocationService}); // Додайте параметр у конструктор

  @override
  _GeolocationScreenState createState() => _GeolocationScreenState();
}

class _GeolocationScreenState extends State<GeolocationScreen> {
  Position? _currentPosition;
  bool _isTracking = false;

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
                if (_isTracking) {
                  setState(() {
                    _isTracking = false;
                  });
                } else {
                  _startTracking();
                }
              },
              child: Text(_isTracking ? 'Stop Tracking' : 'Start Tracking'),
            ),
            SizedBox(height: 20),
            Text(_currentPosition != null
                ? 'Latitude: ${_currentPosition!.latitude}, Longitude: ${_currentPosition!.longitude}'
                : 'Location data not available'),
          ],
        ),
      ),
    );
  }

  void _startTracking() {
    setState(() {
      _isTracking = true;
    });

    _getCurrentLocation();
  }

  void _getCurrentLocation() async {
    while (_isTracking) {
      try {
        Position position = await widget.geolocationService.determinePosition(); // Використовуйте метод з сервісу через поле widget.geolocationService
        setState(() {
          _currentPosition = position;
        });
      } catch (e) {
        print('Error getting location: $e');
      }
      await Future.delayed(Duration(seconds: 1));
    }
  }
}
