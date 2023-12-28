import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/src/features/search/data/event_search_data.dart';
import 'package:myapp/src/features/search/data/person_data.dart';
import 'package:myapp/src/features/search/logic/search_state.dart';

class SearchBloc extends Cubit<SearchState> {
  SearchBloc() : super(SearchState.ds());

  void _search() {
    if (state.searchValue != "") {
      switch (state.type) {
        case TypeSearch.event:
          final result = events
              .where((element) => element.name
                  .toLowerCase()
                  .contains(state.searchValue.toLowerCase()))
              .toList();
          emit(state.copyWith(resultEvent: result));
          break;
        case TypeSearch.people:
          final result = persons
              .where((element) => element.name
                  .toLowerCase()
                  .contains(state.searchValue.toLowerCase()))
              .toList();
          emit(state.copyWith(resultPerson: result));
          break;
        default:
      }
    } else {
      emit(state.copyWith(resultPerson: [], resultEvent: []));
    }
  }

  void setSearchValue(String value) {
    emit(state.copyWith(searchValue: value));
    _search();
  }

  void setType(int page) {
    if (page == 0) {
      emit(state.copyWith(type: TypeSearch.event, resultEvent: []));
    } else {
      emit(state.copyWith(type: TypeSearch.people, resultPerson: []));
    }
    _search();
  }
}
