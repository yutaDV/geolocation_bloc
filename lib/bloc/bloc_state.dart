import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';

abstract class GeolocationState extends Equatable {
  const GeolocationState();

  @override
  List<Object?> get props => [];
}

class GeolocationInitial extends GeolocationState {}

class GeolocationTrackingState extends GeolocationState {
  final Position position;

  GeolocationTrackingState(this.position);

  @override
  List<Object?> get props => [position];
}
