import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/src/features/search/data/event_search_data.dart';
import 'package:myapp/src/features/search/data/person_data.dart';
import 'package:myapp/src/features/search/logic/search_state.dart';

class SearchBloc extends Cubit<SearchState> {
  SearchBloc() : super(SearchState.ds());

  void _search() {
    List<dynamic>? result;
    if (state.searchValue != "") {
      switch (state.type) {
        case TypeSearch.event:
          result = events
              .where((element) => element.name
                  .toLowerCase()
                  .contains(state.searchValue.toLowerCase()))
              .toList();
          break;
        case TypeSearch.people:
          result = persons
              .where((element) => element.name
                  .toLowerCase()
                  .contains(state.searchValue.toLowerCase()))
              .toList();
          break;
        default:
      }
    } else {
      result = [];
    }
    emit(state.copyWith(result: result));
  }

  void setSearchValue(String value) {
    emit(state.copyWith(searchValue: value));
    _search();
  }

  void setType(int page) {
    if (page == 0) {
      emit(state.copyWith(type: TypeSearch.event));
    } else {
      emit(state.copyWith(type: TypeSearch.people));
    }
    _search();
  }
}
