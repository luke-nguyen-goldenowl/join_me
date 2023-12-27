class SearchState {
  String searchValue;
  SearchState({this.searchValue = "hello"});
  SearchState copyWith({
    searchValue,
  }) {
    return SearchState(
      searchValue: searchValue ?? this.searchValue,
    );
  }
}
