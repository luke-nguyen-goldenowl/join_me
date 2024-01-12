// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/src/network/model/user_story/user_story.dart';
import 'package:story_view/story_view.dart';
import 'package:myapp/src/features/home/story/logic/story_widget_bloc.dart';
import 'package:myapp/src/features/home/story/logic/story_widget_state.dart';
import 'package:myapp/src/features/home/story/widget/event_item_story.dart';
import 'package:myapp/src/features/home/story/widget/profile_widget.dart';
import 'package:myapp/src/network/model/event/event.dart';
import 'package:myapp/src/network/model/story/story.dart';
import 'package:myapp/src/network/model/user/user.dart';
import 'package:myapp/src/router/coordinator.dart';

class StoryWidget extends StatelessWidget {
  final MUser user;
  final List<MStory> stories;
  final PageController controller;

  const StoryWidget({
    super.key,
    required this.user,
    required this.controller,
    required this.stories,
    required this.userStory,
    required this.handleSeenStory,
  });
  final Function(int, int) handleSeenStory;
  final List<MUserStory> userStory;
  void _handleCompleted() {
    controller.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeIn,
    );

    final currentIndex =
        userStory.indexWhere((element) => element.user.id == user.id);
    final isLastPage = userStory.length - 1 == currentIndex;

    if (isLastPage) {
      AppCoordinator.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => StoryWidgetBloc(stories: stories, host: user),
      child: BlocBuilder<StoryWidgetBloc, StoryWidgetState>(
        buildWhen: (previous, current) {
          return previous.date != current.date ||
              previous.indexStory != current.indexStory ||
              !listEquals(previous.storyItems, current.storyItems);
        },
        builder: (context, state) {
          return Stack(
            children: <Widget>[
              Material(
                type: MaterialType.transparency,
                child: StoryView(
                  storyItems: state.storyItems,
                  controller: context.read<StoryWidgetBloc>().controller,
                  onComplete: _handleCompleted,
                  onVerticalSwipeComplete: (direction) {
                    if (direction == Direction.down) {
                      AppCoordinator.pop();
                    }
                  },
                  onStoryShow: (storyItem) {
                    final index = state.storyItems.indexOf(storyItem);
                    context.read<StoryWidgetBloc>().handleOnStoryShow(
                        stories, index, handleSeenStory, userStory);
                  },
                ),
              ),
              ProfileWidget(
                user: user,
                date: state.date,
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: EventItem(
                  event: stories[state.indexStory].event ?? MEvent(),
                  handlePress: (event) {
                    AppCoordinator.showEventDetails(id: event.id ?? "");
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
