// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:latlong2/latlong.dart';

class MapPageState {
  LatLng? currentLocation;
  MapPageState({
    this.currentLocation,
  });

  MapPageState copyWith({
    LatLng? currentLocation,
  }) {
    return MapPageState(
      currentLocation: currentLocation ?? this.currentLocation,
    );
  }

  @override
  bool operator ==(covariant MapPageState other) {
    if (identical(this, other)) return true;

    return other.currentLocation == currentLocation;
  }

  @override
  int get hashCode => currentLocation.hashCode;
}
