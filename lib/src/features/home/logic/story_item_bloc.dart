import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/src/features/home/logic/story_item_state.dart';

class StoryItemBloc extends Cubit<StoryItemState> {
  StoryItemBloc() : super(StoryItemState.ds());

  void initState({required bool isView}) {
    emit(state.copyWith(isView: isView));
  }

  void setIsView() {
    emit(state.copyWith(isView: !state.isView));
  }
}
