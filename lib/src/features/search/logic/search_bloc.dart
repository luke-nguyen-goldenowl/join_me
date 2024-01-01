import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/src/features/search/logic/search_state.dart';
import 'package:myapp/src/network/domain_manager.dart';

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
              final result = domain.event.getEventsSearch(state.searchValue);
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

class Debounce {
  final Duration delay;
  VoidCallback? action;

  Timer? _timer;

  Debounce(this.delay);

  void run(VoidCallback action) {
    if (_timer != null) {
      _timer!.cancel();
    }
    _timer = Timer(delay, action);
  }
}
