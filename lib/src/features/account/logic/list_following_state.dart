// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:myapp/src/network/model/user/user.dart';

class ListFollowingState {
  List<MUser> followings;
  ListFollowingState({
    this.followings = const [],
  });

  ListFollowingState copyWith({
    List<MUser>? followings,
  }) {
    return ListFollowingState(
      followings: followings ?? this.followings,
    );
  }
}
