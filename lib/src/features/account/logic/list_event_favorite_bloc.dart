import 'package:myapp/src/features/account/logic/list_event_favorite_state.dart';
import 'package:myapp/src/features/common/logic/pagination_bloc.dart';

import 'package:myapp/src/network/domain_manager.dart';
import 'package:myapp/src/network/model/common/pagination/pagination.dart';
import 'package:myapp/src/network/model/common/pagination/pagination_response.dart';
import 'package:myapp/src/network/model/common/result.dart';
import 'package:myapp/src/network/model/event/event.dart';

class ListEventFavoriteBloc extends PaginationBloc<ListEventFavoriteState> {
  ListEventFavoriteBloc()
      : super(ListEventFavoriteState(data: MPagination<MEvent>(), userId: ''));
  DomainManager get domain => DomainManager();

  void setUserId(String userId) {
    emit(state.copyWith(userId: userId));
  }

  @override
  Future<MResult<MPaginationResponse>> get getDataAPI async {
    await Future.delayed(const Duration(seconds: 2));

    return domain.event.getEventsByUser(state.userId);
  }
}
