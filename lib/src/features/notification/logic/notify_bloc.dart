import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/src/features/notification/logic/notify_state.dart';
import 'package:myapp/src/network/domain_manager.dart';

class NotifyBloc extends Cubit<NotifyState> {
  NotifyBloc() : super(NotifyState.ds());
  DomainManager get domain => DomainManager();

  void getNotifies() {
    final result = domain.notification.getNotifies("1");
    emit(state.copyWith(notifies: result.data));
  }
}
