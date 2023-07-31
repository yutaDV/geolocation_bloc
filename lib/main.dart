import 'package:flutter/material.dart';
import 'geolocation_screen.dart';
import 'geolocation_service.dart'; // Імпортуйте ваш GeolocationService

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final geolocationService = GeolocationService();

    return MaterialApp(
      title: 'Geolocation App',
      home: GeolocationScreen(geolocationService: geolocationService),
    );
  }
}
