import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:myapp/src/features/account/logic/account_bloc.dart';
import 'package:myapp/src/features/search/logic/search_state.dart';
import 'package:myapp/src/network/domain_manager.dart';
import 'package:myapp/src/network/model/common/debounce.dart';

class SearchBloc extends Cubit<SearchState> {
  SearchBloc() : super(SearchState.ds());
  DomainManager get domain => DomainManager();
  final debounce = Debounce(const Duration(milliseconds: 500));
  final user = GetIt.I<AccountBloc>().state.user;
  void _search() async {
    if (state.searchValue != "") {
      emit(state.copyWith(isLoading: true));
      switch (state.type) {
        case TypeSearch.event:
          final result =
              await domain.event.getEventsBySearch(state.searchValue, user.id);
          if (result.isSuccess) {
            if (!isClosed) {
              emit(state.copyWith(
                  resultEvent: result.data,
                  isLoading: false,
                  isNotFound: result.data!.isEmpty));
            }
          }

          break;
        case TypeSearch.people:
          final result =
              await domain.user.getUsersBySearch(state.searchValue, user.id);
          if (result.isSuccess) {
            if (!isClosed) {
              emit(state.copyWith(
                  resultPerson: result.data,
                  isLoading: false,
                  isNotFound: result.data!.isEmpty));
            }
          }
          break;
        default:
          if (!isClosed) {
            emit(state.copyWith(
                resultPerson: [],
                resultEvent: [],
                isLoading: false,
                isNotFound: false));
          }
      }
    } else {
      if (!isClosed) {
        emit(state
            .copyWith(resultPerson: [], resultEvent: [], isNotFound: false));
      }
    }
  }

  void setSearchValue(String value) {
    emit(state.copyWith(searchValue: value));
    debounce.run(_search);
  }

  void setType(int page) {
    if (page == 0) {
      emit(state.copyWith(type: TypeSearch.event));
    } else {
      emit(state.copyWith(type: TypeSearch.people));
    }
    debounce.run(_search);
  }
}
