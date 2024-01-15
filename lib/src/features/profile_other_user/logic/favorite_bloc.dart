import 'package:myapp/src/features/common/logic/pagination_bloc.dart';
import 'package:myapp/src/features/profile_other_user/logic/favorite_state.dart';
import 'package:myapp/src/network/domain_manager.dart';
import 'package:myapp/src/network/model/common/pagination/pagination.dart';
import 'package:myapp/src/network/model/common/pagination/pagination_response.dart';
import 'package:myapp/src/network/model/common/result.dart';
import 'package:myapp/src/network/model/event/event.dart';

class FavoriteBloc extends PaginationBloc<FavoriteState> {
  FavoriteBloc({required String userId})
      : super(FavoriteState(data: MPagination<MEvent>(), userId: userId));
  DomainManager get domain => DomainManager();
  @override
  Future<MResult<MPaginationResponse<MEvent>>> get getDataAPI async {
    return await domain.event
        .getEventsFavoriteByUser(state.userId, state.data.lastDoc);
  }
}
