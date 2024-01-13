import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:myapp/src/features/event/logic/event_view_bloc.dart';
import 'package:myapp/src/features/event/logic/event_view_state.dart';
import 'package:myapp/src/features/event/logic/map_page_bloc.dart';
import 'package:myapp/src/features/event/logic/map_page_state.dart';

class MapPage extends StatelessWidget {
  const MapPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EventViewBloc, EventViewState>(
      buildWhen: (previous, current) =>
          !listEquals(previous.events, current.events),
      builder: ((contextEvent, stateEvent) {
        return BlocProvider(
          create: (_) => MapPageBloc(events: stateEvent.events),
          child: MapPageWidget(),
        );
      }),
    );
  }
}

class MapPageWidget extends StatelessWidget {
  const MapPageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MapPageBloc, MapPageState>(
      buildWhen: (previous, current) =>
          !listEquals(previous.events, current.events) ||
          !listEquals(previous.markers, current.markers) ||
          previous.currentLocation != current.currentLocation,
      builder: ((context, state) {
        if (!state.isLoadingCurrentLocation) {
          return GoogleMap(
            mapType: MapType.terrain,
            onMapCreated: context.read<MapPageBloc>().onMapCreate,
            initialCameraPosition: CameraPosition(
              target:
                  state.currentLocation ?? const LatLng(10.790159, 106.6557574),
              zoom: 14,
            ),
            myLocationEnabled: true,
            markers: state.markers.toSet(),
          );
        } else {
          return ListView(
            children: [
              const Center(
                child: CircularProgressIndicator(),
              ),
              for (int i = 0; i < state.events.length; i++)
                Transform.translate(
                  offset: Offset(
                    -MediaQuery.of(context).size.width * 2,
                    -MediaQuery.of(context).size.height * 2,
                  ),
                  child: RepaintBoundary(
                    key: state.dataMarker[i].globalKey,
                    child: state.dataMarker[i].widget,
                  ),
                ),
            ],
          );
        }
      }),
    );
  }
}
