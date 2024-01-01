// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:myapp/src/network/model/event/event.dart';
import 'package:myapp/src/network/model/user/user.dart';

enum TypeSearch { event, people }

class SearchState {
  String searchValue;
  TypeSearch type;
  List<MUser> resultPerson;
  List<MEvent> resultEvent;
  SearchState({
    required this.searchValue,
    required this.type,
    required this.resultPerson,
    required this.resultEvent,
  });

  factory SearchState.ds() {
    return SearchState(
        searchValue: "",
        type: TypeSearch.event,
        resultPerson: [],
        resultEvent: []);
  }

  SearchState copyWith({
    String? searchValue,
    TypeSearch? type,
    List<MUser>? resultPerson,
    List<MEvent>? resultEvent,
  }) {
    return SearchState(
      searchValue: searchValue ?? this.searchValue,
      type: type ?? this.type,
      resultPerson: resultPerson ?? this.resultPerson,
      resultEvent: resultEvent ?? this.resultEvent,
    );
  }
}
