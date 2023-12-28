import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/src/features/home/story/logic/story_view_state.dart';

class StoryViewBloc extends Cubit<StoryViewState> {
  StoryViewBloc(super.initialState);

  PageController controller = PageController();

  @override
  Future<void> close() {
    controller.dispose();
    return super.close();
  }
}
