import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/src/features/search/data/event_search_data.dart';
import 'package:myapp/src/features/search/logic/search_bloc.dart';
import 'package:myapp/src/features/search/logic/search_state.dart';
import 'package:myapp/src/features/search/widget/event_search_widget.dart';

class EventTabSearch extends StatelessWidget {
  const EventTabSearch({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(builder: ((context, state) {
      return ListView.builder(
        itemCount: state.result.length,
        itemBuilder: (context, index) {
          return EventSearchWidget(event: state.result[index]);
        },
      );
    }));
  }
}
