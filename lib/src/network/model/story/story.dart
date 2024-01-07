// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';
import 'package:myapp/src/network/model/event/event.dart';
import 'package:myapp/src/network/model/user/user.dart';

class MStory {
  String? id;
  String? image;
  DateTime? time;
  MUser? host;
  MEvent? event;
  List<String>? likers;
  List<String>? viewers;

  MStory({
    this.id,
    this.image,
    this.time,
    this.host,
    this.event,
    this.likers,
    this.viewers,
  });

  MStory copyWith({
    String? id,
    String? image,
    DateTime? time,
    MUser? host,
    MEvent? event,
    List<String>? likers,
    List<String>? viewers,
  }) {
    return MStory(
      id: id ?? this.id,
      image: image ?? this.image,
      time: time ?? this.time,
      host: host ?? this.host,
      event: event ?? this.event,
      likers: likers ?? this.likers,
      viewers: viewers ?? this.viewers,
    );
  }

  @override
  bool operator ==(covariant MStory other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.image == image &&
        other.time == time &&
        other.host == host &&
        other.event == event &&
        listEquals(other.likers, likers) &&
        listEquals(other.viewers, viewers);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        image.hashCode ^
        time.hashCode ^
        host.hashCode ^
        event.hashCode ^
        likers.hashCode ^
        viewers.hashCode;
  }

  factory MStory.fromMap(Map<String, dynamic> map, String id) {
    return MStory(
      id: id,
      image: map['image'] ?? "",
      time: map['time'] != null ? DateTime.parse(map['time']) : null,
      host: MUser(id: map['host']),
      event: MEvent(id: map['event']),
      likers: map['liker'] ?? [],
      viewers: map['viewers'] ?? [],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'image': image,
      'time': time?.toIso8601String(),
      'host': host?.id,
      'event': event?.id,
      'likers': likers ?? [],
      'viewers': viewers ?? []
    };
  }
}
