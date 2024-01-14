// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:myapp/src/network/model/user/user.dart';

class MFollowUser {
  MUser host;
  MUser follower;
  MFollowUser({
    required this.host,
    required this.follower,
  });

  MFollowUser copyWith({
    MUser? host,
    MUser? follower,
  }) {
    return MFollowUser(
      host: host ?? this.host,
      follower: follower ?? this.follower,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'host': host.toMap(),
      'follower': follower.toMap()
    };
  }

  factory MFollowUser.fromMap(Map<String, dynamic> map) {
    return MFollowUser(
      host: MUser.fromMap(map['host'] as Map<String, dynamic>),
      follower: MUser.fromMap(map['follower'] as Map<String, dynamic>),
    );
  }

  @override
  bool operator ==(covariant MFollowUser other) {
    if (identical(this, other)) return true;

    return other.host == host && other.follower == follower;
  }

  @override
  int get hashCode => host.hashCode ^ follower.hashCode;
}
