import 'package:myapp/src/network/model/event/event.dart';
import 'package:myapp/src/network/model/user/user.dart';

class MStory {
  String? id;
  String image;
  DateTime? time;
  MUser host;
  MEvent event;
  int liker;

  MStory({
    required this.id,
    required this.host,
    required this.event,
    this.image = "",
    this.liker = 0,
    this.time,
  });

  MStory copyWith({
    String? id,
    String? image,
    DateTime? time,
    MUser? host,
    MEvent? event,
    int? liker,
  }) {
    return MStory(
      id: id ?? this.id,
      host: host ?? this.host,
      event: event ?? this.event,
      image: image ?? this.image,
      liker: liker ?? this.liker,
      time: time ?? this.time,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MStory &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          image == other.image &&
          time == other.time &&
          host == other.host &&
          event == other.event &&
          liker == other.liker;

  @override
  int get hashCode =>
      id.hashCode ^
      image.hashCode ^
      time.hashCode ^
      host.hashCode ^
      event.hashCode ^
      liker.hashCode;

  factory MStory.fromMap(Map<String, dynamic> map, String id) {
    return MStory(
      id: id,
      image: map['image'] ?? "",
      time: map['time'] != null ? DateTime.parse(map['time']) : null,
      host: MUser(id: map['host']),
      event: MEvent(id: map['event']),
      liker: map['liker'] ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'image': image,
      'time': time?.toIso8601String(),
      'host': host.id,
      'event': event.id,
      'liker': liker,
    };
  }
}
