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
    return BlocBuilder<SearchBloc, SearchState>(buildWhen: (previous, current) {
      return previous.searchValue != current.searchValue ||
          previous.type != current.type ||
          !listEquals(current.resultEvent, previous.resultEvent);
    }, builder: ((context, state) {
      return state.resultEvent.isEmpty && state.searchValue.isNotEmpty
          ? const Center(
              child: Text("Not found!"),
            )
          : ListView.builder(
              itemCount: state.resultEvent.length,
              itemBuilder: (context, index) {
                return EventSearchWidget(event: state.resultEvent[index]);
              },
            );
    }));
  }
}
