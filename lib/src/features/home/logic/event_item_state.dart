class EventItemState {
  EventItemState({this.isLiked = false});
  bool isLiked;
  EventItemState copyWith({bool? value}) {
    return EventItemState(isLiked: value ?? isLiked);
  }
}
