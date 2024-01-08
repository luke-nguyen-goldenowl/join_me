import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:myapp/src/features/home/story/logic/add_story_bloc.dart';
import 'package:myapp/src/features/home/story/logic/add_story_state.dart';
import 'package:myapp/src/features/home/story/widget/event_item_story.dart';
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
    return BlocBuilder<AddStoryBloc, AddStoryState>(
      builder: ((context, state) {
        return Scaffold(
            body: Stack(
          children: [
            state.image != null
                ? Expanded(
                    child: Container(
                      color: AppColors.black,
                      alignment: Alignment.center,
                      child: Image.file(
                        File(state.image!.path),
                        fit: BoxFit.contain,
                      ),
                    ),
                  )
                : Container(
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
                    onPressed: () {
                      AppCoordinator.pop();
                    },
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
            if (state.eventId != "")
              Align(
                  alignment: Alignment.bottomCenter,
                  child:
                      Container() // EventItem(storyId: state.eventId, handlePress: () {}),
                  )
          ],
        ));
      }),
    );
  }
}

class AddEventBar extends StatelessWidget {
  const AddEventBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButtonAddEvent(
            icon: const Icon(Icons.camera_alt),
            handlePress: () {
              context.read<AddStoryBloc>().pickImage(ImageSource.camera);
            },
          ),
          const SizedBox(height: 20),
          IconButtonAddEvent(
            icon: const Icon(Icons.image),
            handlePress: () {
              context.read<AddStoryBloc>().pickImage(ImageSource.gallery);
            },
          ),
          const SizedBox(height: 20),
          IconButtonAddEvent(
            icon: const Icon(Icons.event_available),
            handlePress: () {
              showMaterialModalBottomSheet(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                  ),
                  backgroundColor: AppColors.iceBlue,
                  context: context,
                  builder: (contextModal) {
                    return SizedBox(
                      height: 700,
                      child: ListView.builder(
                        itemCount: 10,
                        itemBuilder: ((contextListView, index) {
                          return
                              // EventItem(
                              //   storyId: index.toString(),
                              //   handlePress: () {
                              //     context.read<AddStoryBloc>().selectEvent(
                              //           index.toString(),
                              //         );
                              //     Navigator.pop(context);
                              //   },
                              // );
                              Container();
                        }),
                      ),
                    );
                  });
            },
          ),
        ],
      ),
    );
  }
}

class IconButtonAddEvent extends StatelessWidget {
  const IconButtonAddEvent({
    super.key,
    required this.handlePress,
    required this.icon,
  });

  final Icon icon;
  final Function() handlePress;

  @override
  Widget build(BuildContext context) {
    return IconButton.filled(
      style: IconButton.styleFrom(
          backgroundColor: AppColors.black.withOpacity(0.2),
          foregroundColor: AppColors.white.withOpacity(0.8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          minimumSize: const Size(60, 60)),
      onPressed: handlePress,
      icon: icon,
      iconSize: 40,
    );
  }
}
