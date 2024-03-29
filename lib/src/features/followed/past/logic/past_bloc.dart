import 'package:get_it/get_it.dart';
import 'package:myapp/src/features/account/logic/account_bloc.dart';
import 'package:myapp/src/features/common/logic/pagination_bloc.dart';
import 'package:myapp/src/features/followed/past/logic/past_state.dart';
import 'package:myapp/src/network/domain_manager.dart';
import 'package:myapp/src/network/model/common/pagination/pagination.dart';
import 'package:myapp/src/network/model/common/pagination/pagination_response.dart';
import 'package:myapp/src/network/model/common/result.dart';

class PastBloc extends PaginationBloc<PastState> {
  PastBloc() : super(PastState(data: MPagination()));
  DomainManager get domain => DomainManager();
  final user = GetIt.I<AccountBloc>().state.user;

  @override
  Future<MResult<MPaginationResponse>> get getDataAPI async {
    return await domain.event.getEventsPastByUser(user.id, state.data.lastDoc);
  }
}
