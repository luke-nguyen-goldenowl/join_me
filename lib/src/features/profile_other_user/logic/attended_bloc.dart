import 'package:myapp/src/features/common/logic/pagination_bloc.dart';
import 'package:myapp/src/features/profile_other_user/logic/attended_state.dart';
import 'package:myapp/src/network/domain_manager.dart';
import 'package:myapp/src/network/model/common/pagination/pagination.dart';
import 'package:myapp/src/network/model/common/pagination/pagination_response.dart';
import 'package:myapp/src/network/model/common/result.dart';

class AttendedBloc extends PaginationBloc<AttendedState> {
  AttendedBloc({required String userId})
      : super(AttendedState(data: MPagination(), userId: userId));
  DomainManager get domain => DomainManager();
  @override
  Future<MResult<MPaginationResponse>> get getDataAPI async {
    return await domain.event
        .getEventsFollowedByUser(state.userId, state.data.lastDoc);
  }
}
