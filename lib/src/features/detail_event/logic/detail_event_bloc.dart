import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/src/features/detail_event/logic/detail_event_state.dart';
import 'package:flutter/material.dart';

class DetailEventBloc extends Cubit<DetailEventState> {
  DetailEventBloc() : super(DetailEventState());
  PageController controller = PageController();

  void setIndexPageImage(int value) {
    emit(state.copyWith(indexPageImage: value));
  }

  @override
  Future<void> close() async {
    controller.dispose();
    super.close();
  }
}
