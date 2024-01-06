import 'package:myapp/src/features/common/logic/pagination_bloc.dart';
import 'package:myapp/src/network/model/common/pagination/pagination.dart';

import 'package:myapp/src/network/model/user/user.dart';

class ListFollowerState extends PaginationState<MUser> {
  const ListFollowerState({required this.userId, required super.data});
  final String userId;
  @override
  ListFollowerState copyWith({MPagination<MUser>? data, String? userId}) {
    return ListFollowerState(
        data: data ?? this.data, userId: userId ?? this.userId);
  }
}
