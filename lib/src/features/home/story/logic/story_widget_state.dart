// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';
import 'package:story_view/story_view.dart';

import 'package:myapp/src/network/model/story/story.dart';
import 'package:myapp/src/network/model/user/user.dart';

class StoryWidgetState {
  List<StoryItem> storyItems;

  MUser host;

  String date;
  int indexStory;

  StoryWidgetState({
    required this.storyItems,
    required this.host,
    required this.date,
    required this.indexStory,
  });

  factory StoryWidgetState.ds() {
    return StoryWidgetState(
      date: '',
      indexStory: 0,
      storyItems: [],
      host: MUser.empty(),
    );
  }

  StoryWidgetState copyWith({
    List<StoryItem>? storyItems,
    List<MStory>? stories,
    MUser? host,
    String? date,
    int? indexStory,
  }) {
    return StoryWidgetState(
      storyItems: storyItems ?? this.storyItems,
      host: host ?? this.host,
      date: date ?? this.date,
      indexStory: indexStory ?? this.indexStory,
    );
  }

  @override
  bool operator ==(covariant StoryWidgetState other) {
    if (identical(this, other)) return true;

    return listEquals(other.storyItems, storyItems) &&
        other.host == host &&
        other.date == date &&
        other.indexStory == indexStory;
  }

  @override
  int get hashCode {
    return storyItems.hashCode ^
        host.hashCode ^
        date.hashCode ^
        indexStory.hashCode;
  }
}
