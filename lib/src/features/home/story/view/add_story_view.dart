// ignore_for_file: curly_braces_in_flow_control_structures

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/src/features/home/story/logic/add_story_bloc.dart';
import 'package:myapp/src/features/home/story/logic/add_story_state.dart';
import 'package:myapp/src/features/home/story/widget/add_event_bar.dart';
import 'package:myapp/src/features/home/story/widget/event_item_story.dart';
import 'package:myapp/src/network/model/event/event.dart';
import 'package:myapp/src/router/coordinator.dart';
import 'package:myapp/src/theme/colors.dart';

class AddStoryView extends StatelessWidget {
  const AddStoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AddStoryBloc(),
      child: const AddStoryPage(),
    );
  }
}

class AddStoryPage extends StatelessWidget {
  const AddStoryPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          BlocBuilder<AddStoryBloc, AddStoryState>(
            buildWhen: (previous, current) => previous.image != current.image,
            builder: ((context, state) {
              if (state.image != null) {
                return Column(
                  children: [
                    Expanded(
                      child: Container(
                        color: AppColors.black,
                        alignment: Alignment.center,
                        child: Image.file(
                          File(state.image!.path),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ],
                );
              } else {
                return Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(colors: AppColors.gradient),
                  ),
                );
              }
            }),
          ),
          BlocBuilder<AddStoryBloc, AddStoryState>(
            buildWhen: (previous, current) =>
                previous.checkCondition() != current.checkCondition(),
            builder: ((context, state) {
              return Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 40, left: 10),
                    child: IconButton(
                      onPressed: (() {
                        AppCoordinator.pop();
                      }),
                      icon: const Icon(
                        Icons.arrow_back,
                        color: AppColors.white,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 40, right: 10),
                    child: ElevatedButton(
                      onPressed: state.checkCondition()
                          ? () {
                              context.read<AddStoryBloc>().onPressPost();
                            }
                          : null,
                      style: ElevatedButton.styleFrom(
                          disabledBackgroundColor:
                              AppColors.grey.withOpacity(0.5),
                          disabledForegroundColor:
                              AppColors.grey4.withOpacity(0.7),
                          minimumSize: const Size(100, 50)),
                      child: const Text(
                        "Post",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  )
                ],
              );
            }),
          ),
          const Align(
            alignment: Alignment.centerRight,
            child: AddEventBar(),
          ),
          BlocBuilder<AddStoryBloc, AddStoryState>(
              buildWhen: (previous, current) => previous.event != current.event,
              builder: ((context, state) {
                if (state.event != null)
                  return Align(
                    alignment: Alignment.bottomCenter,
                    child: EventItem(
                        event: state.event!, handlePress: (MEvent event) {}),
                  );
                return const SizedBox.shrink();
              })),
        ],
      ),
    );
  }
}
