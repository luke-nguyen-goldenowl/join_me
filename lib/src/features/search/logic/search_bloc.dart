import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/src/features/search/logic/search_state.dart';

class SearchBloc extends Cubit<SearchState> {
  SearchBloc() : super(SearchState());

  void setSearchValue(String value) {
    emit(state.copyWith(searchValue: value));
  }
}
