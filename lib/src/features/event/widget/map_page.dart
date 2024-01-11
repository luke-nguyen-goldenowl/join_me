import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
          previous.firstDate != current.firstDate ||
          previous.lastDate != current.lastDate ||
          previous.typeShow != current.typeShow ||
          !listEquals(previous.weekDays, current.weekDays) ||
          !listEquals(previous.types, current.types),
      builder: ((contextEvent, stateEvent) {
        return BlocProvider(
          create: (_) => MapPageBloc()
            ..getCurrentLocation()
            ..getEvent(),
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
        if (!state.isLoadingCurrentLocation) {
          return Container();
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      }),
    );
  }
}
