// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:myapp/src/network/model/event/event.dart';

class MChangeEvent {
  String id;
  MEvent event;
  MChangeEvent({
    required this.id,
    required this.event,
  });

  MChangeEvent copyWith({
    String? id,
    MEvent? event,
  }) {
    return MChangeEvent(
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

  factory MChangeEvent.fromMap(Map<String, dynamic> map) {
    return MChangeEvent(
      id: map['id'] as String,
      event: MEvent.fromMap(map['event'] as Map<String, dynamic>, ""),
    );
  }

  String toJson() => json.encode(toMap());

  factory MChangeEvent.fromJson(String source) =>
      MChangeEvent.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'MChangeEvent(id: $id, event: $event)';

  @override
  bool operator ==(covariant MChangeEvent other) {
    if (identical(this, other)) return true;

    return other.id == id && other.event == event;
  }

  @override
  int get hashCode => id.hashCode ^ event.hashCode;
}
