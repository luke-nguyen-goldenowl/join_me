// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';

import 'package:myapp/src/network/model/event/event.dart';
import 'package:myapp/src/network/model/user_story/user_story.dart';

enum TypeListEventHome {
  popular("Popular"),
  upcoming("Upcoming"),
  people("Your friend organized it"),
  followed("Followed");

  final String text;
  const TypeListEventHome(this.text);
}

class HomeState {
  List<MEvent> popular;
  List<MEvent> upcoming;
  List<MEvent> people;
  List<MEvent> followed;
  List<MUserStory> userStory;

  HomeState({
    required this.popular,
    required this.upcoming,
    required this.people,
    required this.followed,
    required this.userStory,
  });

  factory HomeState.ds() {
    return HomeState(
        followed: [], upcoming: [], people: [], popular: [], userStory: []);
  }

  @override
  bool operator ==(covariant HomeState other) {
    if (identical(this, other)) return true;

    return listEquals(other.popular, popular) &&
        listEquals(other.upcoming, upcoming) &&
        listEquals(other.people, people) &&
        listEquals(other.followed, followed) &&
        listEquals(other.userStory, userStory);
  }

  @override
  int get hashCode {
    return popular.hashCode ^
        upcoming.hashCode ^
        people.hashCode ^
        followed.hashCode ^
        userStory.hashCode;
  }

  HomeState copyWith({
    List<MEvent>? popular,
    List<MEvent>? upcoming,
    List<MEvent>? people,
    List<MEvent>? followed,
    List<MUserStory>? userStory,
  }) {
    return HomeState(
      popular: popular ?? this.popular,
      upcoming: upcoming ?? this.upcoming,
      people: people ?? this.people,
      followed: followed ?? this.followed,
      userStory: userStory ?? this.userStory,
    );
  }
}
