import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/src/features/search/logic/search_state.dart';
import 'package:myapp/src/network/domain_manager.dart';
import 'package:myapp/src/network/model/common/debounce.dart';

class SearchBloc extends Cubit<SearchState> {
  SearchBloc() : super(SearchState.ds());
  DomainManager get domain => DomainManager();
  final debounce = Debounce(const Duration(milliseconds: 500));

  void _search() {
    if (state.searchValue != "") {
      switch (state.type) {
        case TypeSearch.event:
          debounce.run(
            () {
              final result =
                  domain.eventMock.getEventsSearch(state.searchValue);
              emit(state.copyWith(resultEvent: result.data));
            },
          );
          break;
        case TypeSearch.people:
          debounce.run(
            () {
              final result = domain.userMock.getUsersSearch(state.searchValue);
              emit(state.copyWith(resultPerson: result.data));
            },
          );
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
