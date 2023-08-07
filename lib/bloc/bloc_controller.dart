import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'bloc_event.dart';
import 'bloc_state.dart';

class GeolocationBloc extends Bloc<GeolocationEvent, GeolocationState> {
  StreamSubscription<Position>? _positionSubscription;

  GeolocationBloc() : super(GeolocationInitial()) {
    on<StartTrackingEvent>(_onStartTrackingEvent);
    on<StopTrackingEvent>(_onStopTrackingEvent);
  }

  void _onStartTrackingEvent(StartTrackingEvent event, Emitter<GeolocationState> emit) {
    _startTracking();
  }

  void _onStopTrackingEvent(StopTrackingEvent event, Emitter<GeolocationState> emit) {
    _stopTracking();
  }

  void _startTracking() async {
    _positionSubscription = Geolocator.getPositionStream().listen((position) {
      add(GeolocationTracking(position));
    });
  }

  void _stopTracking() {
    _positionSubscription?.cancel();
  }

  @override
  Future<void> close() {
    _stopTracking();
    return super.close();
  }
}
