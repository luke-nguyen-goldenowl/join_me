// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:myapp/src/network/model/event/event.dart';
import 'package:myapp/src/network/model/user/user.dart';

class MChangeEvent {
  MEvent event;
  MUser host;
  MChangeEvent({
    required this.event,
    required this.host,
  });

  MChangeEvent copyWith({
    MEvent? event,
    MUser? host,
  }) {
    return MChangeEvent(
      event: event ?? this.event,
      host: host ?? this.host,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'event': event.toMap(),
      'eventId': event.id ?? "",
      'hostEvent': host.toMap()
    };
  }

  factory MChangeEvent.fromMap(Map<String, dynamic> map) {
    return MChangeEvent(
        event: MEvent.fromMap(
          map['event'] as Map<String, dynamic>,
          map['eventId'],
        ),
        host: MUser.fromMap(map['hostEvent']));
  }
}
