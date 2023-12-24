import 'package:flutter/material.dart';
import 'package:myapp/src/features/home/data/users.dart';
import 'package:myapp/src/features/home/model/story.dart';
import 'package:myapp/src/features/home/model/user.dart';
import 'package:myapp/src/features/home/story/widget/profile_widget.dart';
import 'package:myapp/src/router/coordinator.dart';
import 'package:myapp/src/theme/colors.dart';
import 'package:story_view/story_view.dart';

class StoryWidget extends StatefulWidget {
  final User user;
  final PageController controller;

  const StoryWidget({
    required this.user,
    required this.controller,
  });

  @override
  _StoryWidgetState createState() => _StoryWidgetState();
}

class _StoryWidgetState extends State<StoryWidget> {
  final storyItems = <StoryItem>[];
  late StoryController controller;
  String date = '';
  int indexStory = 0;
  late String storyId;

  void addStoryItems() {
    for (final story in widget.user.stories) {
      switch (story.mediaType) {
        case MediaType.image:
          storyItems.add(StoryItem.pageImage(
            url: story.url,
            controller: controller,
            caption: story.caption,
            duration: Duration(
              milliseconds: (story.duration * 1000).toInt(),
            ),
          ));
          break;
        case MediaType.text:
          storyItems.add(
            StoryItem.text(
              title: story.caption,
              backgroundColor: story.color,
              duration: Duration(
                milliseconds: (story.duration * 1000).toInt(),
              ),
            ),
          );
          break;
      }
    }
  }

  @override
  void initState() {
    super.initState();

    controller = StoryController();
    addStoryItems();
    date = widget.user.stories[0].date;
    storyId = widget.user.stories[0].id;
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void handleCompleted() {
    widget.controller.nextPage(
      duration: Duration(milliseconds: 300),
      curve: Curves.easeIn,
    );

    final currentIndex = users.indexOf(widget.user);
    final isLastPage = users.length - 1 == currentIndex;

    if (isLastPage) {
      AppCoordinator.pop();
    }
  }

  @override
  Widget build(BuildContext context) => Stack(
        children: <Widget>[
          Material(
            type: MaterialType.transparency,
            child: StoryView(
              storyItems: storyItems,
              controller: controller,
              onComplete: handleCompleted,
              onVerticalSwipeComplete: (direction) {
                if (direction == Direction.down) {
                  AppCoordinator.pop();
                }
              },
              onStoryShow: (storyItem) {
                final index = storyItems.indexOf(storyItem);

                if (index > 0) {
                  setState(() {
                    date = widget.user.stories[index].date;
                    storyId = widget.user.stories[index].id;
                    indexStory = index;
                  });
                }
              },
            ),
          ),
          ProfileWidget(
            user: widget.user,
            date: date,
          ),
          EventItem(storyId: storyId, indexStory: indexStory, date: date),
          Align(
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
          )
        ],
      );
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
