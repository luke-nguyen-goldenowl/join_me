// ignore_for_file: curly_braces_in_flow_control_structures
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/src/features/search/logic/search_bloc.dart';
import 'package:myapp/src/features/search/logic/search_state.dart';
import 'package:myapp/src/features/search/widget/event_search_widget.dart';

class EventTabSearch extends StatelessWidget {
  const EventTabSearch({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      buildWhen: (previous, current) =>
          previous.isLoading != current.isLoading ||
          !listEquals(previous.resultEvent, current.resultEvent) ||
          previous.isNotFound != current.isNotFound,
      builder: ((context, state) {
        if (state.isLoading) {
          return Container(
              alignment: Alignment.center,
              child: const CircularProgressIndicator());
        } else if (state.isNotFound)
          return const Center(
            child: Text("Not found!"),
          );
        else
          return ListView.builder(
            itemCount: state.resultEvent.length,
            itemBuilder: (context, index) {
              return EventSearchWidget(event: state.resultEvent[index]);
            },
          );
      }),
    );
  }
}
