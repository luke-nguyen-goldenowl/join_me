// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:myapp/src/network/model/event/event.dart';
import 'package:myapp/src/network/model/user/user.dart';

class MFollowEvent {
  MEvent event;
  MUser user;
  MFollowEvent({
    required this.event,
    required this.user,
  });

  MFollowEvent copyWith({
    MEvent? event,
    MUser? user,
  }) {
    return MFollowEvent(
      event: event ?? this.event,
      user: user ?? this.user,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'event': event.toMap(),
      'eventId': event.id ?? "",
      'user': user.toMap(),
    };
  }

  factory MFollowEvent.fromMap(Map<String, dynamic> map) {
    return MFollowEvent(
      event:
          MEvent.fromMap(map['event'] as Map<String, dynamic>, map['eventId']),
      user: MUser.fromMap(map['user'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory MFollowEvent.fromJson(String source) =>
      MFollowEvent.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool operator ==(covariant MFollowEvent other) {
    if (identical(this, other)) return true;

    return other.event == event && other.user == user;
  }

  @override
  int get hashCode => event.hashCode ^ user.hashCode;
}
