// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';

import 'package:myapp/src/utils/utils.dart';

class MUser {
  String id;
  String? name;
  String? avatar;
  String? email;
  List<String>? followers;
  List<String>? followed;
  List<String> fcmToken;
  MUser({
    required this.id,
    this.name,
    this.avatar,
    this.email,
    this.followers,
    this.followed,
    this.fcmToken = const [],
  });

  factory MUser.empty() {
    return MUser(id: '');
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'avatar': avatar,
      'email': email,
      'followers': followers ?? [],
      'followed': followed ?? [],
      'caseSearchName': getCaseSearchName(name),
      'fcmToken': fcmToken,
    };
  }

  static List<String> getCaseSearchName(String? name) {
    if (name == null || name == "") return [];

    List<String> listWord = name.split(' ');
    String word = listWord.removeLast();
    List<String> result = Utils.getCaseSearch(word);

    listWord.reversed.toList().forEach((element) {
      word = "$element $word";
      result.addAll(Utils.getCaseSearch(word));
    });

    return result;
  }

  factory MUser.fromMap(Map<String, dynamic> map) {
    return MUser(
      id: map['id'],
      name: map['name'],
      avatar: map['avatar'],
      email: map['email'],
      followers: List<String>.from((map['followers'])),
      followed: List<String>.from((map['followed'])),
      fcmToken:
          map['fcmToken'] != null ? List<String>.from((map['fcmToken'])) : [],
    );
  }

  MUser copyWith({
    String? id,
    String? name,
    String? avatar,
    String? email,
    List<String>? followers,
    List<String>? followed,
    List<String>? fcmToken,
  }) {
    return MUser(
      id: id ?? this.id,
      name: name ?? this.name,
      avatar: avatar ?? this.avatar,
      email: email ?? this.email,
      followers: followers ?? this.followers,
      followed: followed ?? this.followed,
      fcmToken: fcmToken ?? this.fcmToken,
    );
  }

  @override
  bool operator ==(covariant MUser other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.avatar == avatar &&
        other.email == email &&
        listEquals(other.followers, followers) &&
        listEquals(other.followed, followed) &&
        listEquals(other.fcmToken, fcmToken);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        avatar.hashCode ^
        email.hashCode ^
        followers.hashCode ^
        followed.hashCode ^
        fcmToken.hashCode;
  }
}
