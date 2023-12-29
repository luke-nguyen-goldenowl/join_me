// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:myapp/src/network/model/event/event.dart';
import 'package:myapp/src/network/model/user/user.dart';

class MUserEvent {
  MUser user;
  List<MEvent> events;
  MUserEvent({
    required this.user,
    required this.events,
  });

  MUserEvent copyWith({
    MUser? user,
    List<MEvent>? events,
  }) {
    return MUserEvent(
      user: user ?? this.user,
      events: events ?? this.events,
    );
  }

  @override
  bool operator ==(covariant MUserEvent other) {
    if (identical(this, other)) return true;

    return other.user == user && listEquals(other.events, events);
  }

  @override
  int get hashCode => user.hashCode ^ events.hashCode;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'user': user.toJson(),
      'events': events.map((x) => x.toMap()).toList(),
    };
  }

  factory MUserEvent.fromMap(Map<String, dynamic> map) {
    return MUserEvent(
      user: MUser.fromJson(map['user'] as Map<String, dynamic>),
      events: List<MEvent>.from(
        (map['events'] as List<int>).map<MEvent>(
          (x) => MEvent.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory MUserEvent.fromJson(String source) =>
      MUserEvent.fromMap(json.decode(source) as Map<String, dynamic>);
}
