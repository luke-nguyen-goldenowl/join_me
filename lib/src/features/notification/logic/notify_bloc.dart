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
  @override
  Future<MResult<MPaginationResponse>> get getDataAPI async {
    await Future.delayed(const Duration(seconds: 2));

    return domain.notification.getNotifies("userId");
  }
}
