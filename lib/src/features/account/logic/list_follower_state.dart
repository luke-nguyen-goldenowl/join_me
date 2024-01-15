// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:myapp/src/network/model/user/user.dart';

class ListFollowerState {
  List<MUser> followers;
  ListFollowerState({
    this.followers = const [],
  });

  ListFollowerState copyWith({
    List<MUser>? followers,
  }) {
    return ListFollowerState(
      followers: followers ?? this.followers,
    );
  }
}
