// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/src/features/event/logic/event_view_bloc.dart';
import 'package:myapp/src/features/event/logic/event_view_state.dart';
import 'package:myapp/src/features/event/widget/calendar_event_widget.dart';
import 'package:myapp/src/features/event/widget/category_event_widget.dart';
import 'package:myapp/src/features/event/widget/list_event_page.dart';
import 'package:myapp/src/features/event/widget/map_page.dart';
import 'package:myapp/src/theme/colors.dart';

import 'package:myapp/widgets/appbar/app_bar_custom.dart';

class EventHomeView extends StatelessWidget {
  const EventHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => EventViewBloc(),
      child: const EventHomePage(),
    );
  }
}

class EventHomePage extends StatelessWidget {
  const EventHomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBarCustom(
        title: const Text("Events"),
        actions: [
          BlocBuilder<EventViewBloc, EventViewState>(
            buildWhen: (previousState, currentState) =>
                previousState.typeShow != currentState.typeShow,
            builder: ((context, state) {
              return IconButton(
                onPressed: () {
                  context.read<EventViewBloc>().updateTypeShow();
                },
                icon: Icon(
                  state.typeShow == TypeShow.list
                      ? Icons.map_rounded
                      : Icons.list,
                  size: 30,
                ),
              );
            }),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            const CategoryEventWidget(),
            const CalendarEventWidget(),
            const SizedBox(height: 10),
            BlocBuilder<EventViewBloc, EventViewState>(
              buildWhen: (previousState, currentState) =>
                  !listEquals(previousState.events, currentState.events) ||
                  previousState.typeShow != currentState.typeShow ||
                  previousState.firstDate != currentState.firstDate ||
                  previousState.lastDate != currentState.lastDate,
              builder: ((context, stateEventView) {
                return Expanded(
                  child: stateEventView.typeShow == TypeShow.list
                      ? const ListEventItemEventView()
                      : const MapPage(),
                );
              }),
            )
          ],
        ),
      ),
    );
  }
}
