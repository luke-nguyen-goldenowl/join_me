// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';
import 'package:latlong2/latlong.dart';

import 'package:myapp/src/network/model/user/user.dart';

enum TypeEvent { sport, game, music, movie }

class MEvent {
  String? id;
  String? name;
  String? description;
  List<String>? images;
  DateTime? startDate;
  DateTime? deadline;
  LatLng? location;
  MUser? host;
  int maxAttendee;
  List<String>? followersId;
  List<String>? favoritesId;
  TypeEvent? type;

  MEvent({
    this.id,
    this.name,
    this.description,
    this.images,
    this.startDate,
    this.deadline,
    this.location,
    this.host,
    this.followersId,
    this.favoritesId,
    this.type,
    this.maxAttendee = 0,
  });

  MEvent copyWith({
    String? id,
    String? name,
    String? description,
    List<String>? images,
    DateTime? startDate,
    DateTime? deadline,
    LatLng? location,
    MUser? host,
    int? maxAttendee,
    List<String>? followersId,
    List<String>? favoritesId,
    TypeEvent? type,
  }) {
    return MEvent(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      images: images ?? this.images,
      startDate: startDate ?? this.startDate,
      deadline: deadline ?? this.deadline,
      location: location ?? this.location,
      host: host ?? this.host,
      maxAttendee: maxAttendee ?? this.maxAttendee,
      followersId: followersId ?? this.followersId,
      favoritesId: favoritesId ?? this.favoritesId,
      type: type ?? this.type,
    );
  }

  factory MEvent.fromMap(Map<String, dynamic> map, String id) {
    return MEvent(
      id: id,
      name: map['name'],
      deadline:
          map['deadline'] != null ? DateTime.parse(map['deadline']) : null,
      description: map['description'],
      host: null,
      maxAttendee: map['maxAttendee'],
      images: List<String>.from(map['images']),
      followersId: List<String>.from(map['followersId']),
      favoritesId: List<String>.from(map['favoritesId']),
      location: map['location'] != null
          ? LatLng(map['location']['latitude'], map['location']['longitude'])
          : null,
      type: getTypeEventFromString(map['type']),
      startDate:
          map['startDate'] != null ? DateTime.parse(map['startDate']) : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'deadline': deadline?.toIso8601String(),
      'description': description,
      'host': host?.id,
      'images': images,
      'favoritesId': favoritesId,
      'followersId': followersId,
      'location': location != null
          ? {'latitude': location!.latitude, 'longitude': location!.longitude}
          : null,
      'startDate': startDate?.toIso8601String(),
      'type': type?.name,
      'maxAttendee': maxAttendee,
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
        other.location == location &&
        other.host == host &&
        other.maxAttendee == maxAttendee &&
        listEquals(other.followersId, followersId) &&
        listEquals(other.favoritesId, favoritesId) &&
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
        location.hashCode ^
        host.hashCode ^
        maxAttendee.hashCode ^
        followersId.hashCode ^
        favoritesId.hashCode ^
        type.hashCode;
  }
}

TypeEvent getTypeEventFromString(String? typeString) {
  if (typeString != null) {
    for (TypeEvent type in TypeEvent.values) {
      if (type.name == typeString) {
        return type;
      }
    }
  }
  return TypeEvent.sport;
}
