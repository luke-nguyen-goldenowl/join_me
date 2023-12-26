import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/src/features/home/data/users.dart';
import 'package:myapp/src/features/home/model/user.dart';
import 'package:myapp/src/features/home/story/logic/story_widget_bloc.dart';
import 'package:myapp/src/features/home/story/logic/story_widget_state.dart';
import 'package:myapp/src/features/home/story/widget/profile_widget.dart';
import 'package:myapp/src/router/coordinator.dart';
import 'package:myapp/src/theme/colors.dart';
import 'package:story_view/story_view.dart';

class StoryWidget extends StatelessWidget {
  final User user;
  final PageController controller;

  const StoryWidget({
    super.key,
    required this.user,
    required this.controller,
  });

  void _handleCompleted() {
    controller.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeIn,
    );

    final currentIndex = users.indexOf(user);
    final isLastPage = users.length - 1 == currentIndex;

    if (isLastPage) {
      AppCoordinator.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => StoryWidgetBloc()..initState(user),
      child: BlocBuilder<StoryWidgetBloc, StoryWidgetState>(
        builder: (context, state) {
          return Stack(
            children: <Widget>[
              Material(
                type: MaterialType.transparency,
                child: StoryView(
                  storyItems: state.storyItems,
                  controller: state.controller,
                  onComplete: _handleCompleted,
                  onVerticalSwipeComplete: (direction) {
                    if (direction == Direction.down) {
                      AppCoordinator.pop();
                    }
                  },
                  onStoryShow: (storyItem) {
                    final index = state.storyItems.indexOf(storyItem);

                    if (index > 0) {
                      context
                          .read<StoryWidgetBloc>()
                          .handleOnStoryShow(user, index);
                    }
                  },
                ),
              ),
              ProfileWidget(
                user: user,
                date: state.date,
              ),
              EventItem(
                  storyId: state.storyId,
                  indexStory: state.indexStory,
                  date: state.date),
              const LikeStory()
            ],
          );
        },
      ),
    );
  }
}

class LikeStory extends StatelessWidget {
  const LikeStory({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: const EdgeInsets.all(20),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: AppColors.black.withOpacity(0.2),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.favorite_border_outlined,
                  color: AppColors.white),
              iconSize: 30,
            ),
            const Text(
              '20',
              style: TextStyle(
                fontSize: 18,
                color: AppColors.white,
                decoration: TextDecoration.none,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class EventItem extends StatelessWidget {
  const EventItem({
    super.key,
    required this.storyId,
    required this.indexStory,
    required this.date,
  });

  final String storyId;
  final int indexStory;
  final String date;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: GestureDetector(
        onTap: () {
          AppCoordinator.showEventDetails(id: storyId);
        },
        child: Container(
          margin: const EdgeInsets.all(20),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Dec 12, 2023 - 11:00 PM $indexStory",
                style: const TextStyle(
                  color: AppColors.grey,
                  fontSize: 15,
                  decoration: TextDecoration.none,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                "Let's play different famous board games, get together every Sunday $date",
                style: const TextStyle(
                  wordSpacing: 0,
                  letterSpacing: 0,
                  color: AppColors.black,
                  fontSize: 18,
                  decoration: TextDecoration.none,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.rosyPink.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: RichText(
                    text: TextSpan(children: [
                  const TextSpan(
                    text: "Followed: ",
                    style: TextStyle(
                      color: AppColors.black,
                      fontSize: 18,
                      decoration: TextDecoration.none,
                    ),
                  ),
                  TextSpan(
                    text: "${indexStory + 100}",
                    style: const TextStyle(
                        color: AppColors.rosyPink,
                        fontSize: 20,
                        decoration: TextDecoration.none,
                        fontWeight: FontWeight.w900),
                  )
                ])),
              )
            ],
          ),
        ),
      ),
    );
  }
}
