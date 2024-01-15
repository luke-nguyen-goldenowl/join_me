// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:myapp/src/network/model/event/event.dart';

class MapPageState {
  LatLng? currentLocation;
  bool isLoadingCurrentLocation;
  List<Marker> markers;
  List<MEvent> events;
  MapPageState({
    this.currentLocation,
    this.isLoadingCurrentLocation = true,
    required this.events,
    required this.markers,
  });

  MapPageState copyWith({
    LatLng? currentLocation,
    bool? isLoadingCurrentLocation,
    List<MEvent>? events,
    List<Marker>? markers,
  }) {
    return MapPageState(
      currentLocation: currentLocation ?? this.currentLocation,
      isLoadingCurrentLocation:
          isLoadingCurrentLocation ?? this.isLoadingCurrentLocation,
      events: events ?? this.events,
      markers: markers ?? this.markers,
    );
  }
}
