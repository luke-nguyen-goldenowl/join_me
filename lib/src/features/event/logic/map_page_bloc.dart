import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:myapp/src/features/event/logic/map_page_state.dart';
import 'package:myapp/src/network/domain_manager.dart';
import 'package:myapp/src/network/model/event/event.dart';
import 'package:myapp/src/router/coordinator.dart';
import 'package:myapp/src/utils/date/date_helper.dart';

class MapPageBloc extends Cubit<MapPageState> {
  MapPageBloc({required List<MEvent> events})
      : super(MapPageState(events: events, markers: []));

  void updateData(List<MEvent> events) {
    emit(state.copyWith(events: events, isLoadingCurrentLocation: true));
    getCurrentLocation();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await onBuildCompleted();
    });
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
      emit(state.copyWith(
          currentLocation: locationLatLng, isLoadingCurrentLocation: false));
    } catch (e) {
      if (kDebugMode) {
        print("Error: $e");
      }
    }
  }

  Future<void> onBuildCompleted() async {
    final markers = await Future.wait(state.events.map((value) async {
      return await generateMarkersFromWidgets(value);
    }));
    emit(state.copyWith(markers: markers));
  }

  Future<Marker> generateMarkersFromWidgets(MEvent event) async {
    const int size = 100;
    final File markerImageFile =
        await DefaultCacheManager().getSingleFile(event.images?[0] ?? "");
    final Uint8List markerImageBytes = await markerImageFile.readAsBytes();
    final Codec markerImageCodec = await instantiateImageCodec(markerImageBytes,
        targetWidth: size, targetHeight: size);
    final FrameInfo frameInfo = await markerImageCodec.getNextFrame();
    final ByteData? byteData = await frameInfo.image.toByteData(
      format: ImageByteFormat.png,
    );
    final Uint8List resizedMarkerImageBytes = byteData!.buffer.asUint8List();

    return Marker(
      markerId: MarkerId(event.id ?? ""),
      position: event.location ?? const LatLng(0, 0),
      icon: BitmapDescriptor.fromBytes(resizedMarkerImageBytes,
          size: const Size.square(0.5)),
      infoWindow: InfoWindow(
        title: event.name,
        snippet: DateHelper.getFullDateTime(event.startDate),
        onTap: () {
          AppCoordinator.showEventDetails(id: event.id ?? "");
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
