import 'package:flutter/foundation.dart';

import 'package:myapp/src/network/model/story/story.dart';
import 'package:myapp/src/network/model/user/user.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class StoryItemState {
  List<MStory> stories;
  MUser host;
  StoryItemState({required this.host, required this.stories});

  StoryItemState copyWith({
    List<MStory>? stories,
    MUser? host,
  }) {
    return StoryItemState(
      stories: stories ?? this.stories,
      host: host ?? this.host,
    );
  }

  @override
  bool operator ==(covariant StoryItemState other) {
    if (identical(this, other)) return true;

    return listEquals(other.stories, stories) && other.host == host;
  }

  @override
  int get hashCode => stories.hashCode ^ host.hashCode;
}
