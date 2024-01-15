import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:myapp/src/dialogs/alert_wrapper.dart';
import 'package:myapp/src/dialogs/toast_wrapper.dart';
import 'package:myapp/src/features/manage_event/edit_event/logic/edit_event_state.dart';
import 'package:myapp/src/network/domain_manager.dart';
import 'package:myapp/src/network/model/event/event.dart';
import 'package:myapp/src/router/coordinator.dart';

class EditEventBloc extends Cubit<EditEventState> {
  EditEventBloc({required String eventId}) : super(EditEventState.ds()) {
    getEvent(eventId);
  }

  PageController controller = PageController(initialPage: 0);
  GoogleMapController? mapController;
  DomainManager domain = DomainManager();

  void onMapCreate(GoogleMapController controller) {
    mapController ??= controller;
  }

  void getEvent(String eventId) async {
    final result = await domain.event.getEvent(eventId);
    if (result.isSuccess) {
      MEvent event = result.data!;
      emit(state.copyWith(
        event: event,
        time: TimeOfDay.fromDateTime(event.startDate!),
      ));
    }
  }

  void setCurrentPage(int index) {
    emit(state.copyWith(currentPage: index));
  }

  void handlePressMap(point) {
    if (!isClosed) {
      emit(state.copyWith(event: state.event.copyWith(location: point)));
    }
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

  void saveEvent() async {
    if (!isClosed) emit(state.copyWith(isSaving: true));

    DateTime? startDate;
    if (state.event.startDate != null && state.time != null) {
      startDate = DateTime(
        state.event.startDate!.year,
        state.event.startDate!.month,
        state.event.startDate!.day,
        state.time!.hour,
        state.time!.minute,
      );
    }
    final MEvent event = state.event.copyWith(
      startDate: startDate,
    );

    final result = await domain.event.updateEvent(event);

    if (!isClosed) emit(state.copyWith(isSaving: false));

    if (result.isSuccess) {
      AppCoordinator.pop(event);
      XToast.success('Update event success');
    } else {
      XAlert.show(title: 'Update event fail', body: result.error);
    }
  }

  void backScreen() {
    AppCoordinator.pop(null);
  }

  @override
  Future<void> close() {
    mapController?.dispose();
    controller.dispose();
    return super.close();
  }
}
