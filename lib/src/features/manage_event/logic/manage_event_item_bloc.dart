import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/src/network/model/event/event.dart';
import 'package:myapp/src/router/coordinator.dart';

class ManageEventItemBloc extends Cubit<MEvent> {
  ManageEventItemBloc(super.initialState);
  void goManageEventDetail() async {
    final event =
        await AppCoordinator.showManageEventDetails(id: state.id ?? "");
    emit(event as MEvent);
  }
}
