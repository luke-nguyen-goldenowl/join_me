class EventItemState {
  EventItemState({required this.isLiked});
  bool isLiked;

  factory EventItemState.ds() {
    return EventItemState(isLiked: false);
  }

  EventItemState copyWith({bool? value}) {
    return EventItemState(isLiked: value ?? isLiked);
  }
}
