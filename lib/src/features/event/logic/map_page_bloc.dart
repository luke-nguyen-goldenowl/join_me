import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import 'package:location/location.dart';
import 'package:myapp/src/features/event/logic/map_page_state.dart';

class MapPageBloc extends Cubit<MapPageState> {
  MapPageBloc() : super(MapPageState());
  MapController mapController = MapController();

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
          return;
        }
      }

      permissionGranted = await location.hasPermission();
      if (permissionGranted == PermissionStatus.denied) {
        permissionGranted = await location.requestPermission();
        if (permissionGranted != PermissionStatus.granted) {
          return;
        }
      }

      currentLocation = await location.getLocation();
      // mapController.move(
      //     LatLng(currentLocation.latitude ?? 0, currentLocation.longitude ?? 0),
      //     13);
      final locationLatLng = LatLng(currentLocation.latitude ?? 10.790159,
          currentLocation.longitude ?? 106.6557574);
      emit(state.copyWith(currentLocation: locationLatLng));
    } catch (e) {
      if (kDebugMode) {
        print("Error: $e");
      }
    }
  }

  @override
  Future<void> close() {
    mapController.dispose();
    return super.close();
  }
}
