import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/src/features/detail_event/logic/detail_event_state.dart';
import 'package:flutter/material.dart';
import 'package:myapp/src/network/domain_manager.dart';

class DetailEventBloc extends Cubit<DetailEventState> {
  DetailEventBloc({eventId}) : super(DetailEventState()) {
    getEvent(eventId);
  }
  PageController controller = PageController();
  DomainManager domain = DomainManager();

  void getEvent(String eventId) {
    final result = domain.event.getEvent(eventId);
    emit(state.copyWith(event: result.data));
  }

  void setIndexPageImage(int value) {
    emit(state.copyWith(indexPageImage: value));
  }

  @override
  Future<void> close() async {
    controller.dispose();
    super.close();
  }
}
