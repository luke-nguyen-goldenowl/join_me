import 'dart:async';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:myapp/src/features/event/logic/data_marker.dart';
import 'package:myapp/src/features/event/logic/map_page_state.dart';
import 'package:myapp/src/features/event/widget/event_location.dart';
import 'package:myapp/src/network/domain_manager.dart';
import 'package:myapp/src/network/model/event/event.dart';
import 'package:myapp/src/router/coordinator.dart';
import 'package:myapp/src/utils/date/date_helper.dart';

class MapPageBloc extends Cubit<MapPageState> {
  MapPageBloc({required List<MEvent> events})
      : super(MapPageState(events: events, markers: [], dataMarker: [])) {
    getCurrentLocation();
    getDataToEvent(events);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await onBuildCompleted();
    });
  }

  void getDataToEvent(List<MEvent> events) {
    final List<DataMarker> data = events
        .map(
          (e) => DataMarker(
            id: e.id ?? "",
            globalKey: GlobalKey(),
            position: e.location ?? const LatLng(0, 0),
            widget: EventLocation(event: e),
            title: e.name ?? "",
            snippet: DateHelper.getFullDateTime(e.startDate),
          ),
        )
        .toList();

    emit(state.copyWith(dataMarker: data));
  }

  DomainManager domain = DomainManager();
  GoogleMapController? mapController;

  void onMapCreate(GoogleMapController controller) {
    mapController ??= controller;
  }

  void getCurrentLocation() async {
    Position currentLocation;
    bool serviceEnabled;
    LocationPermission permission;
    try {
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        return Future.error('Location services are disabled.');
      }

      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          return Future.error('Location permissions are denied');
        }
      }

      if (permission == LocationPermission.deniedForever) {
        return Future.error(
            'Location permissions are permanently denied, we cannot request permissions.');
      }
      currentLocation = await Geolocator.getCurrentPosition();
      final locationLatLng =
          LatLng(currentLocation.latitude, currentLocation.longitude);
      emit(state.copyWith(currentLocation: locationLatLng));
    } catch (e) {
      if (kDebugMode) {
        print("Error: $e");
      }
    }
  }

  Future<void> onBuildCompleted() async {
    final List<Marker> markers =
        await Future.wait(state.dataMarker.map((value) async {
      return await generateMarkersFromWidgets(value);
    }));
    emit(state.copyWith(markers: markers, isLoadingCurrentLocation: false));
  }

  Future<Marker> generateMarkersFromWidgets(DataMarker data) async {
    RenderRepaintBoundary boundary = data.globalKey.currentContext
        ?.findRenderObject() as RenderRepaintBoundary;
    final image = await boundary.toImage(pixelRatio: 3);
    ByteData? byteData = await image.toByteData(
      format: ImageByteFormat.png,
    );
    if (byteData != null) {
      return Marker(
        markerId: MarkerId(data.id),
        position: data.position,
        icon: BitmapDescriptor.fromBytes(byteData.buffer.asUint8List()),
        infoWindow: InfoWindow(
          title: data.title,
          snippet: data.snippet,
          onTap: () {
            AppCoordinator.showEventDetails(id: data.id);
          },
        ),
      );
    }
    return Marker(
      markerId: MarkerId(data.id),
      position: data.position,
      infoWindow: InfoWindow(
        title: data.title,
        snippet: data.snippet,
        onTap: () {
          AppCoordinator.showEventDetails(id: data.id);
        },
      ),
    );
  }

  @override
  Future<void> close() {
    mapController?.dispose();

    return super.close();
  }
}
