import 'package:get_it/get_it.dart';
import 'package:myapp/src/features/account/logic/account_bloc.dart';
import 'package:myapp/src/features/common/logic/pagination_bloc.dart';
import 'package:myapp/src/features/notification/logic/notify_state.dart';
import 'package:myapp/src/network/domain_manager.dart';
import 'package:myapp/src/network/model/common/pagination/pagination.dart';
import 'package:myapp/src/network/model/common/pagination/pagination_response.dart';
import 'package:myapp/src/network/model/common/result.dart';
import 'package:myapp/src/network/model/notification/notification_model.dart';

class NotifyBloc extends PaginationBloc<NotifyState> {
  NotifyBloc() : super(NotifyState(data: MPagination<NotificationModel>()));
  DomainManager get domain => DomainManager();
  final user = GetIt.I<AccountBloc>().state.user;

  @override
  Future<MResult<MPaginationResponse<NotificationModel>>> get getDataAPI async {
    return await domain.notification
        .getNotification(user.id, state.data.lastDoc);
  }
}
