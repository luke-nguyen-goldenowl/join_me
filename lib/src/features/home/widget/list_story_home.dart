import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/src/features/home/data/users.dart';
import 'package:myapp/src/features/home/logic/story_item_bloc.dart';
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
        Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          height: 60,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: users.length + 1,
            itemBuilder: (context, index) {
              return BlocProvider(
                create: (_) => StoryItemBloc(),
                child: Row(
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
                        : StoryItem(
                            id: users[index - 1].id,
                          ),
                    const SizedBox(width: 15)
                  ],
                ),
              );
            },
          ),
        )
      ],
    );
  }
}
