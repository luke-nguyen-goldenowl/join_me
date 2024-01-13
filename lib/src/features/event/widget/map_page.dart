import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:myapp/src/features/event/logic/map_page_bloc.dart';
import 'package:myapp/src/features/event/logic/map_page_state.dart';
import 'package:myapp/src/network/model/event/event.dart';

class MapPage extends StatelessWidget {
  MapPage({
    super.key,
    required this.events,
  });
  final List<MEvent> events;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => MapPageBloc(events: events),
      child: MapPageWidget(
        events: events,
      ),
    );
  }
}

class MapPageWidget extends StatelessWidget {
  const MapPageWidget({super.key, required this.events});
  final List<MEvent> events;
  @override
  Widget build(BuildContext context) {
    context.read<MapPageBloc>().updateData(events);
    return BlocBuilder<MapPageBloc, MapPageState>(
      buildWhen: (previous, current) =>
          !listEquals(previous.events, current.events) ||
          !listEquals(previous.markers, current.markers) ||
          previous.currentLocation != current.currentLocation ||
          previous.isLoadingCurrentLocation != current.isLoadingCurrentLocation,
      builder: ((context, state) {
        if (!state.isLoadingCurrentLocation) {
          return Expanded(
            child: GoogleMap(
              mapType: MapType.terrain,
              onMapCreated: context.read<MapPageBloc>().onMapCreate,
              initialCameraPosition: CameraPosition(
                target: state.currentLocation ??
                    const LatLng(10.790159, 106.6557574),
                zoom: 14,
              ),
              myLocationEnabled: true,
              markers: state.markers.toSet(),
            ),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      }),
    );
  }
}
