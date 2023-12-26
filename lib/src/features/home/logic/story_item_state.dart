class StoryItemState {
  bool isView;
  StoryItemState({this.isView = false});

  StoryItemState copyWith({bool? isView}) {
    return StoryItemState(isView: isView ?? this.isView);
  }
}
