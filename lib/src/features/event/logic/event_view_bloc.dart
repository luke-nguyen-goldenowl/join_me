import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/src/dialogs/toast_wrapper.dart';
import 'package:myapp/src/features/event/logic/event_view_state.dart';
import 'package:myapp/src/network/domain_manager.dart';
import 'package:myapp/src/network/model/event/event.dart';

class EventViewBloc extends Cubit<EventViewState> {
  EventViewBloc() : super(EventViewState.ds()) {
    updateWeekDays(DateTime.now());
  }

  DomainManager get domain => DomainManager();

  void updateWeekDays(DateTime date) {
    DateTime firstDayOfWeek = date.subtract(Duration(days: date.weekday - 1));

    List<DateTime> weekDays = [];

    for (int i = 0; i < 7; i++) {
      weekDays.add(firstDayOfWeek.add(Duration(days: i)));
    }

    emit(state.copyWith(
      weekDays: weekDays,
      firstDate: weekDays.first,
      lastDate: weekDays.last,
    ));
    getEvent();
  }

  void updateTypeShow() {
    switch (state.typeShow) {
      case TypeShow.list:
        emit(state.copyWith(typeShow: TypeShow.map));
        break;
      case TypeShow.map:
        emit(state.copyWith(typeShow: TypeShow.list));
        break;
      default:
        break;
    }
  }

  void getEvent() async {
    XToast.showLoading();
    final result = await domain.event
        .getEventsByFilter(state.types, state.firstDate, state.lastDate);
    if (result.isSuccess) {
      emit(state.copyWith(events: result.data));
    }
    XToast.hideLoading();
  }

  void updateTypes(TypeEvent type) {
    List<TypeEvent> types = [...state.types];
    if (!types.remove(type)) types.add(type);

    emit(state.copyWith(
      types: types,
    ));

    getEvent();
  }
}
