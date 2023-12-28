import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/src/features/notification/logic/notify_state.dart';

class NotifyBloc extends Cubit<NotifyState> {
  NotifyBloc() : super(NotifyState.ds());
}
