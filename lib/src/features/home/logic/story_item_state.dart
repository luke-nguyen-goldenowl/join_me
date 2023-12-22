class StoryItemState {
  bool isView;
  StoryItemState({required this.isView});

  factory StoryItemState.ds() {
    return StoryItemState(isView: false);
  }

  StoryItemState copyWith({bool? isView}) {
    return StoryItemState(isView: isView ?? this.isView);
  }
}
