// ignore_for_file: must_be_immutable

import 'package:myapp/src/features/common/logic/pagination_bloc.dart';
import 'package:myapp/src/network/model/common/pagination/pagination.dart';
import 'package:myapp/src/network/model/user/user.dart';

class FollowersState extends PaginationState<MUser> {
  FollowersState({required super.data, required this.followerIds});
  List<String> followerIds;
  @override
  FollowersState copyWith(
      {MPagination<MUser>? data, List<String>? followerIds}) {
    return FollowersState(
      data: data ?? this.data,
      followerIds: followerIds ?? this.followerIds,
    );
  }
}
