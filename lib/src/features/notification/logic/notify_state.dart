import 'package:myapp/src/features/common/logic/pagination_bloc.dart';
import 'package:myapp/src/network/model/common/pagination/pagination.dart';
import 'package:myapp/src/network/model/notification/notification_model.dart';

class NotifyState extends PaginationState<NotificationModel> {
  const NotifyState({required super.data});

  @override
  NotifyState copyWith({MPagination<NotificationModel>? data}) {
    return NotifyState(data: data ?? this.data);
  }
}
