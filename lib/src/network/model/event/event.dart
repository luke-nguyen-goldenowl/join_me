import 'package:flutter/foundation.dart';
import 'package:latlong2/latlong.dart';
import 'package:myapp/src/network/model/user/user.dart';

class MEvent {
  String id;
  String name;
  String description;
  List<String> images;
  DateTime? startDate;
  DateTime? deadline;
  String province;
  LatLng? location;
  MUser host;
  int follower;

  MEvent({
    required this.id,
    required this.name,
    required this.deadline,
    required this.description,
    required this.follower,
    required this.host,
    required this.images,
    required this.location,
    required this.province,
    required this.startDate,
  });

  factory MEvent.ds({
    required String id,
    required MUser host,
  }) {
    return MEvent(
      id: id,
      name: "",
      deadline: null,
      description: "",
      follower: 0,
      host: host,
      images: [],
      location: null,
      province: "",
      startDate: null,
    );
  }

  MEvent copyWith({
    String? id,
    String? name,
    DateTime? deadline,
    String? description,
    int? follower,
    MUser? host,
    List<String>? images,
    LatLng? location,
    String? province,
    DateTime? startDate,
  }) {
    return MEvent(
      id: id ?? this.id,
      name: name ?? this.name,
      deadline: deadline ?? this.deadline,
      description: description ?? this.description,
      follower: follower ?? this.follower,
      host: host ?? this.host,
      images: images ?? this.images,
      location: location ?? this.location,
      province: province ?? this.province,
      startDate: startDate ?? this.startDate,
    );
  }

  factory MEvent.fromMap(Map<String, dynamic> map) {
    return MEvent(
      id: map['id'],
      name: map['name'],
      deadline:
          map['deadline'] != null ? DateTime.parse(map['deadline']) : null,
      description: map['description'],
      follower: map['follower'],
      host: MUser.fromJson(map['host']),
      images: List<String>.from(map['images']),
      location: map['location'] != null
          ? LatLng(map['location']['latitude'], map['location']['longitude'])
          : null,
      province: map['province'],
      startDate:
          map['startDate'] != null ? DateTime.parse(map['startDate']) : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'deadline': deadline?.toIso8601String(),
      'description': description,
      'follower': follower,
      // 'host': host.toMap(),
      'images': images,
      'location': location != null
          ? {'latitude': location!.latitude, 'longitude': location!.longitude}
          : null,
      'province': province,
      'startDate': startDate?.toIso8601String(),
    };
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MEvent &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          deadline == other.deadline &&
          description == other.description &&
          follower == other.follower &&
          host == other.host &&
          listEquals(images, other.images) &&
          location == other.location &&
          province == other.province &&
          startDate == other.startDate;

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      deadline.hashCode ^
      description.hashCode ^
      follower.hashCode ^
      host.hashCode ^
      images.hashCode ^
      location.hashCode ^
      province.hashCode ^
      startDate.hashCode;
}
