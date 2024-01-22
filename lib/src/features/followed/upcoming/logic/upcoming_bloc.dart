import 'package:get_it/get_it.dart';
import 'package:myapp/src/features/account/logic/account_bloc.dart';
import 'package:myapp/src/features/common/logic/pagination_bloc.dart';
import 'package:myapp/src/features/followed/upcoming/logic/upcoming_state.dart';
import 'package:myapp/src/network/domain_manager.dart';
import 'package:myapp/src/network/model/common/pagination/pagination.dart';
import 'package:myapp/src/network/model/common/pagination/pagination_response.dart';
import 'package:myapp/src/network/model/common/result.dart';

class UpcomingBloc extends PaginationBloc<UpComingState> {
  UpcomingBloc() : super(UpComingState(data: MPagination()));
  final user = GetIt.I<AccountBloc>().state.user;
  DomainManager get domain => DomainManager();
  @override
  Future<MResult<MPaginationResponse>> get getDataAPI async {
    return await domain.event
        .getEventsUpcomingByUser(user.id, state.data.lastDoc);
  }
}
