// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';

import 'package:myapp/src/network/model/event/event.dart';

enum TypeListEventHome {
  popular("Popular"),
  upcoming("Upcoming"),
  people("Your friend organized it"),
  followed("Followed");

  final String text;
  const TypeListEventHome(this.text);
}

class HomeState {
  MEvent selectedEventToLike;

  List<MEvent> popular;
  List<MEvent> upcoming;
  List<MEvent> people;
  List<MEvent> followed;
  HomeState({
    required this.selectedEventToLike,
    required this.popular,
    required this.upcoming,
    required this.people,
    required this.followed,
  });

  factory HomeState.ds() {
    return HomeState(
      followed: [],
      upcoming: [],
      people: [],
      popular: [],
      selectedEventToLike: MEvent(id: "", favoritesId: []),
    );
  }

  @override
  bool operator ==(covariant HomeState other) {
    if (identical(this, other)) return true;

    return other.selectedEventToLike == selectedEventToLike &&
        listEquals(other.popular, popular) &&
        listEquals(other.upcoming, upcoming) &&
        listEquals(other.people, people) &&
        listEquals(other.followed, followed);
  }

  @override
  int get hashCode {
    return selectedEventToLike.hashCode ^
        popular.hashCode ^
        upcoming.hashCode ^
        people.hashCode ^
        followed.hashCode;
  }

  HomeState copyWith({
    MEvent? selectedEventToLike,
    List<MEvent>? popular,
    List<MEvent>? upcoming,
    List<MEvent>? people,
    List<MEvent>? followed,
  }) {
    return HomeState(
      selectedEventToLike: selectedEventToLike ?? this.selectedEventToLike,
      popular: popular ?? this.popular,
      upcoming: upcoming ?? this.upcoming,
      people: people ?? this.people,
      followed: followed ?? this.followed,
    );
  }
}
