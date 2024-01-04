// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

import 'package:myapp/src/network/model/event/event.dart';

class AddStoryState {
  XFile? image;
  String eventId;
  List<MEvent>? events;
  AddStoryState({
    this.image,
    this.eventId = "",
    this.events,
  });

  AddStoryState copyWith({
    XFile? image,
    String? eventId,
    List<MEvent>? events,
  }) {
    return AddStoryState(
      image: image ?? this.image,
      eventId: eventId ?? this.eventId,
      events: events ?? this.events,
    );
  }

  @override
  bool operator ==(covariant AddStoryState other) {
    if (identical(this, other)) return true;

    return other.image == image &&
        other.eventId == eventId &&
        listEquals(other.events, events);
  }

  @override
  int get hashCode => image.hashCode ^ eventId.hashCode ^ events.hashCode;
}
