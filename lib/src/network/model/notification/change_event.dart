// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:myapp/src/network/model/event/event.dart';

class MChangeEvent {
  MEvent event;
  MChangeEvent({
    required this.event,
  });

  MChangeEvent copyWith({
    MEvent? event,
  }) {
    return MChangeEvent(
      event: event ?? this.event,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'event': event.toMap(),
      'eventId': event.id ?? "",
    };
  }

  factory MChangeEvent.fromMap(Map<String, dynamic> map) {
    return MChangeEvent(
      event: MEvent.fromMap(
        map['event'] as Map<String, dynamic>,
        map['eventId'],
      ),
    );
  }
}
