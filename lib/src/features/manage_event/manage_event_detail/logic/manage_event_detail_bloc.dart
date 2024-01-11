import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/src/features/manage_event/manage_event_detail/logic/manage_event_detail_state.dart';

class ManageEventDetailBloc extends Cubit<ManageEventDetailState> {
  ManageEventDetailBloc() : super(ManageEventDetailState());
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
