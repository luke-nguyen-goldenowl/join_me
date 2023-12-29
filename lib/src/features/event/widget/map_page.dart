import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/src/features/event/logic/event_view_bloc.dart';
import 'package:myapp/src/features/event/logic/event_view_state.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:myapp/src/features/event/logic/map_page_bloc.dart';
import 'package:myapp/src/features/event/logic/map_page_state.dart';
import 'package:myapp/src/features/event/widget/event_location.dart';
import 'package:myapp/src/theme/colors.dart';

class MapPage extends StatelessWidget {
  const MapPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EventViewBloc, EventViewState>(
      buildWhen: (previous, current) => previous != current,
      builder: ((contextEvent, stateEvent) {
        return BlocProvider(
          create: (_) => MapPageBloc()..getCurrentLocation(),
          child: const MapPageWidget(),
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
      builder: ((context, state) {
        if (state.currentLocation != null) {
          return FlutterMap(
            mapController: context.read<MapPageBloc>().mapController,
            options: MapOptions(
              center: state.currentLocation,
              zoom: 13.0,
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.example.app',
              ),
              MarkerLayer(
                markers: [
                  Marker(
                    rotate: true,
                    width: 50.0,
                    height: 50.0,
                    point: state.currentLocation ?? LatLng(0, 0),
                    builder: (BuildContext context) {
                      return const Icon(
                        Icons.my_location,
                        color: AppColors.rosyPink,
                        size: 40,
                      );
                    },
                  ),
                  Marker(
                    rotate: true,
                    width: 300.0,
                    height: 150.0,
                    point: LatLng((state.currentLocation?.latitude ?? 0) + 4,
                        (state.currentLocation?.longitude ?? 0) + 4),
                    builder: (BuildContext context) {
                      return const EventLocation();
                    },
                  ),
                ],
              ),
            ],
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
