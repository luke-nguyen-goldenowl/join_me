import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/src/features/event/logic/event_view_bloc.dart';
import 'package:myapp/src/features/event/logic/event_view_state.dart';
import 'package:myapp/src/features/event/widget/calendar_event_widget.dart';
import 'package:myapp/src/features/event/widget/category_event_widget.dart';
import 'package:myapp/src/features/event/widget/map_page.dart';
import 'package:myapp/src/features/home/logic/event_item_bloc.dart';
import 'package:myapp/src/features/home/widget/event_item_home.dart';
import 'package:myapp/src/theme/colors.dart';

import 'package:myapp/widgets/appbar/app_bar_custom.dart';

class EventHomeView extends StatelessWidget {
  const EventHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => EventViewBloc()..updateWeekDays(DateTime.now()),
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
    return BlocBuilder<EventViewBloc, EventViewState>(
      buildWhen: (previousState, currentState) {
        return previousState != currentState;
      },
      builder: ((context, state) {
        return Scaffold(
          backgroundColor: AppColors.white,
          appBar: AppBarCustom(
            title: "Events",
            actions: [
              IconButton(
                onPressed: () {
                  context.read<EventViewBloc>().updateTypeShow();
                },
                icon: Icon(
                  state.typeShow == TypeShow.list
                      ? Icons.map_rounded
                      : Icons.list,
                  size: 30,
                ),
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
                Expanded(
                  child: state.typeShow == TypeShow.list
                      ? const ListEventItemEventView()
                      : const MapPage(),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}

class ListEventItemEventView extends StatelessWidget {
  const ListEventItemEventView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return BlocProvider(
                create: (_) => EventItemBloc()..initIsLike(Random().nextBool()),
                child: Column(
                  children: [
                    SizedBox(
                      height: 250,
                      child: EventItemHome(id: index.toString()),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              );
            },
            childCount: 50,
          ),
        ),
      ],
    );
  }
}
