import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/src/features/home/story/logic/story_view_bloc.dart';
import 'package:myapp/src/features/home/story/logic/story_view_state.dart';
import 'package:myapp/src/features/home/story/widget/story_widget.dart';
import 'package:myapp/src/network/model/user_story/user_story.dart';

class StoryView extends StatelessWidget {
  const StoryView(
      {super.key,
      required this.id,
      required this.userStory,
      required this.handleSeenStory});
  final String id;
  final List<MUserStory> userStory;
  final Function(int, int) handleSeenStory;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => StoryViewBloc()..initState(id, userStory),
      child: BlocBuilder<StoryViewBloc, StoryViewState>(
        builder: (context, state) {
          return PageView.builder(
            controller: context.read<StoryViewBloc>().controller,
            onPageChanged: ((value) {
              print('chuyển page nè $value');
            }),
            itemCount: state.userStory.length,
            itemBuilder: (context, index) {
              return StoryWidget(
                user: state.userStory[index].user,
                controller: context.read<StoryViewBloc>().controller,
                stories: state.userStory[index].stories,
                userStory: state.userStory,
                handleSeenStory: handleSeenStory,
              );
            },
          );
        },
      ),
    );
  }
}
