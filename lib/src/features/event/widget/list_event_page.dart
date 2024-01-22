import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/src/features/event/logic/event_view_bloc.dart';
import 'package:myapp/src/features/event/logic/event_view_state.dart';
import 'package:myapp/src/features/event/widget/event_item_event.dart';

class ListEventItemEventView extends StatelessWidget {
  const ListEventItemEventView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EventViewBloc, EventViewState>(
      buildWhen: (previous, current) =>
          !listEquals(previous.events, current.events),
      builder: ((context, state) {
        return RefreshIndicator(
          onRefresh: context.read<EventViewBloc>().refreshData,
          child: ListView.builder(
            itemCount: state.events.length,
            itemBuilder: ((context, index) {
              return Column(
                children: [
                  SizedBox(
                    height: 250,
                    child: EventItemEvent(
                      event: state.events[index],
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              );
            }),
          ),
        );
      }),
    );
  }
}
