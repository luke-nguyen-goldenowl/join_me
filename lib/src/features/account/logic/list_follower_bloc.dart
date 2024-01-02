import 'package:myapp/src/features/account/logic/list_follower_state.dart';
import 'package:myapp/src/features/common/logic/pagination_bloc.dart';

import 'package:myapp/src/network/domain_manager.dart';
import 'package:myapp/src/network/model/common/pagination/pagination.dart';
import 'package:myapp/src/network/model/common/pagination/pagination_response.dart';
import 'package:myapp/src/network/model/common/result.dart';

import 'package:myapp/src/network/model/user/user.dart';

class ListFollowerBloc extends PaginationBloc<ListFollowerState> {
  ListFollowerBloc()
      : super(ListFollowerState(data: MPagination<MUser>(), userId: ''));
  DomainManager get domain => DomainManager();

  void setUserId(String userId) {
    emit(state.copyWith(userId: userId));
  }

  @override
  Future<MResult<MPaginationResponse>> get getDataAPI async {
    await Future.delayed(const Duration(seconds: 2));

    return domain.userMock.getFavoriteListByUser(state.userId);
  }
}
