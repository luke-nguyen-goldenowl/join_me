import 'package:story_view/story_view.dart';

class StoryWidgetState {
  List<StoryItem> storyItems;

  String date;
  int indexStory;
  String storyId;

  StoryWidgetState({
    required this.date,
    required this.indexStory,
    required this.storyId,
    required this.storyItems,
  });

  factory StoryWidgetState.ds() {
    return StoryWidgetState(
      date: '',
      indexStory: 0,
      storyId: '',
      storyItems: [],
    );
  }

  StoryWidgetState copyWith({
    date,
    indexStory,
    storyId,
    storyItems,
  }) {
    return StoryWidgetState(
      indexStory: indexStory ?? this.indexStory,
      date: date ?? this.date,
      storyId: storyId ?? this.storyId,
      storyItems: storyItems ?? this.storyItems,
    );
  }
}
