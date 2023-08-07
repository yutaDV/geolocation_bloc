import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/bloc_controller.dart';
import 'geolocation_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Your Geolocation',
      home: BlocProvider(
        create: (context) => GeolocationBloc(),
        child: GeolocationScreen(),
      ),
    );
  }
}
