import 'package:flutter/foundation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'package:myapp/src/network/model/user/user.dart';
import 'package:myapp/src/utils/utils.dart';

enum TypeEvent {
  sport("Sport", Icons.sports_basketball),
  game("Game", Icons.games_rounded),
  music("Music", Icons.music_note_rounded),
  movie("Movie", Icons.movie_creation_outlined),
  photo("Photo", Icons.photo),
  travel("Travel", Icons.flight),
  painting("Painting", Icons.format_paint_outlined),
  education("Education", Icons.cast_for_education);

  final String text;
  final IconData icon;
  const TypeEvent(this.text, this.icon);
}

class MEvent {
  String? id;
  String? name;
  String? description;
  List<String>? images;
  DateTime? startDate;
  DateTime? deadline;
  LatLng? location;
  MUser? host;
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
      followersId: followersId ?? this.followersId,
      favoritesId: favoritesId ?? this.favoritesId,
      type: type ?? this.type,
    );
  }

  factory MEvent.empty() {
    return MEvent(
      id: "",
      name: "",
      description: "",
      images: [],
      favoritesId: [],
      followersId: [],
      host: MUser.empty(),
      location: null,
      type: null,
      deadline: null,
      startDate: null,
    );
  }

  factory MEvent.fromMap(Map<String, dynamic> map, String id) {
    return MEvent(
      id: id,
      name: map['name'],
      deadline:
          map['deadline'] != null ? DateTime.parse(map['deadline']) : null,
      description: map['description'],
      host: MUser(id: map['host']),
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
      'countFavorites': favoritesId?.length ?? 0,
      'followersId': followersId,
      'countFollowers': followersId?.length ?? 0,
      'location': location != null
          ? {'latitude': location!.latitude, 'longitude': location!.longitude}
          : null,
      'startDate': startDate?.toIso8601String(),
      'type': type?.name,
      'caseSearchName': _getCaseSearchName
    };
  }

  List<String> get _getCaseSearchName {
    List<String> listWord = name?.split(' ') ?? [];
    String word = listWord.removeLast();
    List<String> result = Utils.getCaseSearch(word);
    listWord.reversed.toList().forEach((element) {
      word = "$element $word";
      result.addAll(Utils.getCaseSearch(word));
    });
    return result;
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
