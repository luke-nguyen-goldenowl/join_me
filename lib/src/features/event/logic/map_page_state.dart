// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';
import 'package:latlong2/latlong.dart';

class MapPageState {
  LatLng? currentLocation;
  bool isLoadingCurrentLocation;
  List<LatLng> events;
  int currentEvent;
  MapPageState({
    this.currentLocation,
    this.isLoadingCurrentLocation = true,
    required this.events,
    this.currentEvent = -1,
  });

  MapPageState copyWith({
    LatLng? currentLocation,
    bool? isLoadingCurrentLocation,
    List<LatLng>? events,
    int? currentEvent,
  }) {
    return MapPageState(
      currentLocation: currentLocation ?? this.currentLocation,
      isLoadingCurrentLocation:
          isLoadingCurrentLocation ?? this.isLoadingCurrentLocation,
      events: events ?? this.events,
      currentEvent: currentEvent ?? this.currentEvent,
    );
  }

  @override
  bool operator ==(covariant MapPageState other) {
    if (identical(this, other)) return true;

    return other.currentLocation == currentLocation &&
        other.isLoadingCurrentLocation == isLoadingCurrentLocation &&
        listEquals(other.events, events) &&
        other.currentEvent == currentEvent;
  }

  @override
  int get hashCode {
    return currentLocation.hashCode ^
        isLoadingCurrentLocation.hashCode ^
        events.hashCode ^
        currentEvent.hashCode;
  }
}
