// ignore_for_file: public_member_api_docs, sort_constructors_first
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
  String type;

  MEvent({
    required this.id,
    required this.name,
    required this.description,
    required this.images,
    required this.startDate,
    required this.deadline,
    required this.province,
    required this.location,
    required this.host,
    required this.follower,
    required this.type,
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
      type: "",
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
    String? type,
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
      type: type ?? this.type,
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
      type: map['type'],
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
      'host': host.toJson(),
      'images': images,
      'location': location != null
          ? {'latitude': location!.latitude, 'longitude': location!.longitude}
          : null,
      'province': province,
      'startDate': startDate?.toIso8601String(),
      'type': type,
    };
  }

  @override
  bool operator ==(covariant MEvent other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.description == description &&
        listEquals(other.images, images) &&
        other.startDate == startDate &&
        other.deadline == deadline &&
        other.province == province &&
        other.location == location &&
        other.host == host &&
        other.follower == follower &&
        other.type == type;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        description.hashCode ^
        images.hashCode ^
        startDate.hashCode ^
        deadline.hashCode ^
        province.hashCode ^
        location.hashCode ^
        host.hashCode ^
        follower.hashCode ^
        type.hashCode;
  }
}
