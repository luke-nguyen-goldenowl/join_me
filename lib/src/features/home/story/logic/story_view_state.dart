// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';
import 'package:myapp/src/network/model/user_story/user_story.dart';

class StoryViewState {
  List<MUserStory> userStory;
  StoryViewState({
    required this.userStory,
  });

  factory StoryViewState.ds() {
    return StoryViewState(userStory: []);
  }

  @override
  bool operator ==(covariant StoryViewState other) {
    if (identical(this, other)) return true;

    return listEquals(other.userStory, userStory);
  }

  @override
  int get hashCode => userStory.hashCode;

  StoryViewState copyWith({
    List<MUserStory>? userStory,
  }) {
    return StoryViewState(
      userStory: userStory ?? this.userStory,
    );
  }
}
