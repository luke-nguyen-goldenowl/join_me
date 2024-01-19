import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/src/features/home/story/logic/add_story_bloc.dart';
import 'package:myapp/src/features/home/story/logic/add_story_state.dart';
import 'package:myapp/src/features/home/story/widget/add_event_bar.dart';
import 'package:myapp/src/features/home/story/widget/event_item_story.dart';
import 'package:myapp/src/network/model/event/event.dart';
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
    return BlocBuilder<AddStoryBloc, AddStoryState>(
      buildWhen: (previous, current) =>
          previous.image != current.image || previous.event != current.event,
      builder: ((context, state) {
        return Scaffold(
          body: Stack(
            children: [
              if (state.image != null)
                Expanded(
                  child: Container(
                    color: AppColors.black,
                    alignment: Alignment.center,
                    child: Image.file(
                      File(state.image!.path),
                      fit: BoxFit.contain,
                    ),
                  ),
                )
              else
                Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(colors: AppColors.gradient),
                  ),
                ),
              AppBar(
                backgroundColor: Colors.transparent,
                foregroundColor: AppColors.white,
                actions: [
                  Container(
                    margin: const EdgeInsets.only(right: 10),
                    child: ElevatedButton(
                      onPressed: state.checkCondition()
                          ? () {
                              context.read<AddStoryBloc>().onPressPost();
                            }
                          : null,
                      style: ElevatedButton.styleFrom(
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
              ),
              const Align(
                alignment: Alignment.centerRight,
                child: AddEventBar(),
              ),
              if (state.event != null)
                Align(
                  alignment: Alignment.bottomCenter,
                  child: EventItem(
                      event: state.event!, handlePress: (MEvent event) {}),
                )
            ],
          ),
        );
      }),
    );
  }
}
