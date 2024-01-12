import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/src/features/home/logic/home_bloc.dart';
import 'package:myapp/src/features/home/logic/home_state.dart';
import 'package:myapp/src/features/home/widget/story_item.dart';
import 'package:myapp/src/features/home/widget/title_home.dart';
import 'package:myapp/src/router/coordinator.dart';
import 'package:myapp/src/theme/colors.dart';

class ListStoryHome extends StatelessWidget {
  const ListStoryHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const TitleHome(title: "Stories"),
        BlocBuilder<HomeBloc, HomeState>(
          buildWhen: (previous, current) =>
              previous.userStory.length != current.userStory.length,
          builder: ((context, state) {
            return Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              height: 60,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: state.userStory.length + 1,
                itemBuilder: (context, index) {
                  return Row(
                    children: [
                      index == 0
                          ? IconButton(
                              onPressed: () {
                                AppCoordinator.showAddStoryScreen();
                              },
                              icon: const Icon(
                                Icons.add,
                                size: 30,
                              ),
                              style: IconButton.styleFrom(
                                backgroundColor: AppColors.rosyPink,
                                foregroundColor: AppColors.white,
                                shape: const CircleBorder(),
                                fixedSize: const Size(50, 50),
                              ),
                            )
                          : BlocBuilder<HomeBloc, HomeState>(
                              buildWhen: (previous, current) => !listEquals(
                                  previous.userStory[index - 1].stories.last
                                      .viewers,
                                  current.userStory[index - 1].stories.last
                                      .viewers),
                              builder: ((context, state) {
                                return StoryItem(
                                  host: state.userStory[index - 1].user,
                                  hostIndex: index - 1,
                                );
                              }),
                            ),
                      const SizedBox(width: 15)
                    ],
                  );
                },
              ),
            );
          }),
        ),
      ],
    );
  }
}
