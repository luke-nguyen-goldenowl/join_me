import 'package:myapp/src/features/common/logic/pagination_bloc.dart';
import 'package:myapp/src/features/manage_event/manage_event_detail/logic/followers_state.dart';
import 'package:myapp/src/network/domain_manager.dart';
import 'package:myapp/src/network/model/common/pagination/meta/pagination_meta.dart';
import 'package:myapp/src/network/model/common/pagination/pagination.dart';
import 'package:myapp/src/network/model/common/pagination/pagination_response.dart';
import 'package:myapp/src/network/model/common/result.dart';
import 'package:myapp/src/network/model/user/user.dart';

class FollowersBloc extends PaginationBloc<FollowersState> {
  FollowersBloc({required List<String> followerIds})
      : super(FollowersState(
            data: MPagination<MUser>(), followerIds: followerIds));
  DomainManager get domain => DomainManager();

  @override
  Future<MResult<MPaginationResponse<MUser>>> get getDataAPI async {
    final data = await domain.user.getUsersByIds(state.followerIds);

    final MPaginationMeta meta;
    if (state.data.countData == -1) {
      meta = MPaginationMeta(
        pageSize: state.data.pageLimit,
        totalCount: state.followerIds.length,
        pageNumber: (state.followerIds.length / state.data.pageLimit).ceil(),
        lastPage: (state.followerIds.length / state.data.pageLimit).ceil(),
      );
    } else {
      meta = MPaginationMeta(
        pageSize: state.data.pageLimit,
        totalCount: state.data.countData,
        pageNumber: (state.data.countData / state.data.pageLimit).ceil(),
        lastPage: (state.data.countData / state.data.pageLimit).ceil(),
      );
    }
    final paginationResponse =
        MPaginationResponse<MUser>(data: data.data ?? [], meta: meta);
    return MResult.success(paginationResponse);
  }

  void setFollowerIds(List<String> followerIds) {
    emit(state.copyWith(followerIds: followerIds));
  }
}
