import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/src/features/search/logic/search_bloc.dart';
import 'package:myapp/src/features/search/logic/search_state.dart';
import 'package:myapp/src/features/search/widget/person_search_widget.dart';

class PeopleTabSearch extends StatelessWidget {
  const PeopleTabSearch({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(builder: ((context, state) {
      return state.resultPerson.isEmpty && state.searchValue.isNotEmpty
          ? const Center(
              child: Text("Not found!"),
            )
          : ListView.builder(
              itemCount: state.resultPerson.length,
              itemBuilder: (context, index) {
                return PersonSearchWidget(person: state.resultPerson[index]);
              },
            );
    }));
  }
}
