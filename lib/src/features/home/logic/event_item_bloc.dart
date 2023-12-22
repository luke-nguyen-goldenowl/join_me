import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/src/features/home/logic/event_item_state.dart';

class EventItemBloc extends Cubit<EventItemState> {
  EventItemBloc() : super(EventItemState.ds());

  void initIsLike(value) {
    emit(state.copyWith(value: value));
  }

  void setIsLike() {
    emit(state.copyWith(value: !state.isLiked));
  }
}
