import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/bloc_controller.dart';
import 'bloc/bloc_event.dart';
import 'bloc/bloc_state.dart';

class GeolocationScreen extends StatelessWidget {
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
                _toggleTracking(context);
              },
              child: Text('Start Tracking'),
            ),
            SizedBox(height: 20),
            BlocConsumer<GeolocationBloc, GeolocationState>(
              listener: (context, state) {
                // Optional: You can handle state changes here if needed
              },
              builder: (context, state) {
                if (state is GeolocationTrackingState) {
                  return Text('Latitude: ${state.position.latitude}, Longitude: ${state.position.longitude}');
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

  void _toggleTracking(BuildContext context) {
    final bloc = BlocProvider.of<GeolocationBloc>(context);
    final currentState = bloc.state;

    if (currentState is GeolocationInitial) {
      // Start tracking if not already tracking
      bloc.add(StartTrackingEvent());
    } else {
      // Stop tracking if already tracking
      bloc.add(StopTrackingEvent());
    }
  }
}
