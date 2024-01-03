// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:myapp/src/network/model/event/event.dart';

class MUpcomingEvent {
  String id;
  MEvent event;
  MUpcomingEvent({
    required this.id,
    required this.event,
  });

  MUpcomingEvent copyWith({
    String? id,
    MEvent? event,
  }) {
    return MUpcomingEvent(
      id: id ?? this.id,
      event: event ?? this.event,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'event': event.toMap(),
    };
  }

  factory MUpcomingEvent.fromMap(Map<String, dynamic> map) {
    return MUpcomingEvent(
      id: map['id'] as String,
      event: MEvent.fromMap(map['event'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory MUpcomingEvent.fromJson(String source) =>
      MUpcomingEvent.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'MUpcomingEvent(id: $id, event: $event)';

  @override
  bool operator ==(covariant MUpcomingEvent other) {
    if (identical(this, other)) return true;

    return other.id == id && other.event == event;
  }

  @override
  int get hashCode => id.hashCode ^ event.hashCode;
}
