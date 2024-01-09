// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/foundation.dart';

import 'package:myapp/src/network/model/story/story.dart';
import 'package:myapp/src/network/model/user/user.dart';

class MUserStory {
  MUser user;
  List<MStory> stories;
  MUserStory({
    required this.user,
    required this.stories,
  });

  @override
  bool operator ==(covariant MUserStory other) {
    if (identical(this, other)) return true;

    return other.user == user && listEquals(other.stories, stories);
  }

  @override
  int get hashCode => user.hashCode ^ stories.hashCode;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'user': user.toJson(),
      'stories': stories.map((x) => x.toMap()).toList(),
    };
  }

  factory MUserStory.fromMap(Map<String, dynamic> map) {
    return MUserStory(
      user: MUser.fromJson(map['user'] as Map<String, dynamic>),
      stories: List<MStory>.from(
        map['stories']?.map((x) => MStory.fromMap(x, "")) ?? [],
      ),
    );
  }

  MUserStory copyWith({
    MUser? user,
    List<MStory>? stories,
  }) {
    return MUserStory(
      user: user ?? this.user,
      stories: stories ?? this.stories,
    );
  }
}
