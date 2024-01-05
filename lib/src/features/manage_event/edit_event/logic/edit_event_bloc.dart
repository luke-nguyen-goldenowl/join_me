import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:myapp/src/features/manage_event/edit_event/logic/edit_event_state.dart';
import 'package:myapp/src/network/model/event/event.dart';

class EditEventBloc extends Cubit<EditEventState> {
  EditEventBloc() : super(EditEventState.ds());

  PageController controller = PageController(initialPage: 0);
  MapController mapController = MapController();

  void initState(MEvent event) {
    emit(state.copyWith(
      event: event,
      // selectedLocation: event.location,
      // nameEvent: event.name,
      // description: event.description,
      // deadlineDate: event.deadline,
      // startDate: event.startDate,
      time: TimeOfDay.fromDateTime(event.startDate!),
    ));
  }

  void setCurrentPage(int index) {
    emit(state.copyWith(currentPage: index));
  }

  void handleTap(point) {
    emit(state.copyWith(event: state.event.copyWith(location: point)));
  }

  void setNameEvent(value) {
    emit(state.copyWith(event: state.event.copyWith(name: value)));
  }

  void setDescriptionEvent(value) {
    emit(state.copyWith(event: state.event.copyWith(description: value)));
  }

  void setStartDateEvent(value) {
    emit(state.copyWith(event: state.event.copyWith(startDate: value)));
  }

  void setDeadlineEvent(value) {
    emit(state.copyWith(event: state.event.copyWith(deadline: value)));
  }

  void setTimeEvent(value) {
    emit(state.copyWith(time: value));
  }

  @override
  Future<void> close() {
    mapController.dispose();
    controller.dispose();
    return super.close();
  }
}
