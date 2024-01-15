import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/src/features/home/story/logic/story_view_state.dart';
import 'package:myapp/src/network/model/user_story/user_story.dart';

class StoryViewBloc extends Cubit<StoryViewState> {
  StoryViewBloc() : super(StoryViewState.ds());

  late PageController controller;
  void initState(String hostId, List<MUserStory> userStory) {
    final index = userStory.indexWhere((element) => element.user.id == hostId);

    controller = PageController(
      initialPage: index >= 0 ? index : 0,
    );
    emit(state.copyWith(userStory: userStory));
  }

  @override
  Future<void> close() {
    controller.dispose();
    return super.close();
  }
}
