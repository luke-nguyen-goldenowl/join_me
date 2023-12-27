enum TypeSearch { event, people }

class SearchState {
  String searchValue;
  TypeSearch type;
  List<dynamic> result;
  SearchState({
    required this.searchValue,
    required this.type,
    required this.result,
  });

  factory SearchState.ds() {
    return SearchState(searchValue: "", type: TypeSearch.event, result: []);
  }

  SearchState copyWith({
    String? searchValue,
    TypeSearch? type,
    List<dynamic>? result,
  }) {
    return SearchState(
      searchValue: searchValue ?? this.searchValue,
      type: type ?? this.type,
      result: result ?? this.result,
    );
  }
}
