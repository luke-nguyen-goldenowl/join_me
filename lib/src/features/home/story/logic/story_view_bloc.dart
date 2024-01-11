import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:myapp/src/features/home/logic/home_bloc.dart';
import 'package:myapp/src/features/home/story/logic/story_view_state.dart';

class StoryViewBloc extends Cubit<StoryViewState> {
  StoryViewBloc() : super(StoryViewState.ds());

  late PageController controller;
  void initState(String hostId) {
    final userStory = GetIt.I<HomeBloc>().state.userStory;
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
