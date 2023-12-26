import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/src/features/detail_event/logic/detail_event_state.dart';

class DetailEventBloc extends Cubit<DetailEventState> {
  DetailEventBloc() : super(DetailEventState.ds());

  void setIndexPageImage(int value) {
    emit(state.copyWith(indexPageImage: value));
  }
}
