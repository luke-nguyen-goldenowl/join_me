import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/src/features/detail_event/logic/detail_event_state.dart';
import 'package:flutter/material.dart';
import 'package:myapp/src/network/domain_manager.dart';
import 'package:myapp/src/network/model/event/event.dart';

class DetailEventBloc extends Cubit<DetailEventState> {
  DetailEventBloc() : super(DetailEventState());
  PageController controller = PageController();

  DomainManager domain = DomainManager();

  void setIndexPageImage(int value) {
    emit(state.copyWith(indexPageImage: value));
  }

  void getEvent(String eventId) async {
    if (!isClosed) emit(state.copyWith(isLoading: true));
    try {
      final result = await domain.event.getEvent("uWbVA0CkBqVxhYZ5QHYT");
      if (result.isSuccess) {
        MEvent event = result.data!;
        emit(state.copyWith(event: event));
      }
    } catch (e) {}
    if (!isClosed) emit(state.copyWith(isLoading: true));
  }
}
