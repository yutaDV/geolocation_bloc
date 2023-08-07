
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';

abstract class GeolocationEvent extends Equatable {
  const GeolocationEvent();

  @override
  List<Object?> get props => [];
}

class StartTrackingEvent extends GeolocationEvent {}

class StopTrackingEvent extends GeolocationEvent {}

class GeolocationTracking extends GeolocationEvent {
  final Position position;

  GeolocationTracking(this.position);

  @override
  List<Object?> get props => [position];
}
