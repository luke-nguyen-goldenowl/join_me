import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import 'package:location/location.dart';
import 'package:myapp/src/features/event/logic/map_page_state.dart';
import 'package:myapp/src/network/domain_manager.dart';

class MapPageBloc extends Cubit<MapPageState> {
  MapPageBloc() : super(MapPageState(events: []));
  MapController mapController = MapController();

  DomainManager domain = DomainManager();

  Future<void> getCurrentLocation() async {
    Location location = Location();
    LocationData currentLocation;
    bool serviceEnabled;
    PermissionStatus permissionGranted;
    try {
      serviceEnabled = await location.serviceEnabled();
      if (!serviceEnabled) {
        serviceEnabled = await location.requestService();
        if (!serviceEnabled) {
          emit(state.copyWith(isLoadingCurrentLocation: false));
          return;
        }
      }

      permissionGranted = await location.hasPermission();
      if (permissionGranted == PermissionStatus.denied) {
        permissionGranted = await location.requestPermission();
        if (permissionGranted != PermissionStatus.granted) {
          emit(state.copyWith(isLoadingCurrentLocation: false));
          return;
        }
      }

      currentLocation = await location.getLocation();

      final locationLatLng = LatLng(currentLocation.latitude ?? 10.790159,
          currentLocation.longitude ?? 106.6557574);
      emit(state.copyWith(
          currentLocation: locationLatLng, isLoadingCurrentLocation: false));
    } catch (e) {
      if (kDebugMode) {
        print("Error: $e");
      }
    }
  }

  void selectEvent(int event) {
    emit(state.copyWith(currentEvent: event));
  }

  void getEvent() {
    final result = domain.eventMock.getAllEvent();
    emit(state.copyWith(events: result.data));
  }

  @override
  Future<void> close() {
    mapController.dispose();
    return super.close();
  }
}
