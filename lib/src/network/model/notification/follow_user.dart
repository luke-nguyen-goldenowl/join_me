// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:myapp/src/network/model/user/user.dart';

class MFollowUser {
  String id;
  MUser user;
  MFollowUser({
    required this.id,
    required this.user,
  });

  MFollowUser copyWith({
    String? id,
    MUser? user,
  }) {
    return MFollowUser(
      id: id ?? this.id,
      user: user ?? this.user,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'user': user.toMap(),
    };
  }

  factory MFollowUser.fromMap(Map<String, dynamic> map) {
    return MFollowUser(
      id: map['id'] as String,
      user: MUser.fromMap(map['user'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory MFollowUser.fromJson(String source) =>
      MFollowUser.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool operator ==(covariant MFollowUser other) {
    if (identical(this, other)) return true;

    return other.id == id && other.user == user;
  }

  @override
  int get hashCode => id.hashCode ^ user.hashCode;
}
