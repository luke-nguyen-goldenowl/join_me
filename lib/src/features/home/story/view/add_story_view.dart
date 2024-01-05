import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:myapp/src/features/home/story/logic/add_story_bloc.dart';
import 'package:myapp/src/features/home/story/logic/add_story_state.dart';
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
      builder: ((context, state) {
        return Stack(
          children: [
            Scaffold(
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
            ),
            if (state.isPosting)
              Container(
                color: AppColors.black.withOpacity(0.5),
                height: double.infinity,
                width: double.infinity,
                alignment: Alignment.center,
                child: const CircularProgressIndicator(
                  color: AppColors.rosyPink,
                ),
              ),
          ],
        );
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
    final addStoryBloc = BlocProvider.of<AddStoryBloc>(context);
    return Container(
      margin: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButtonAddEvent(
            icon: const Icon(Icons.camera_alt),
            handlePress: () {
              addStoryBloc.pickImage(ImageSource.camera);
            },
          ),
          const SizedBox(height: 20),
          IconButtonAddEvent(
            icon: const Icon(Icons.image),
            handlePress: () {
              addStoryBloc.pickImage(ImageSource.gallery);
            },
          ),
          const SizedBox(height: 20),
          IconButtonAddEvent(
            icon: const Icon(Icons.event_available),
            handlePress: () async {
              await addStoryBloc.getEvents();

              // ignore: use_build_context_synchronously
              final result = await showMaterialModalBottomSheet<MEvent>(
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
                      child: addStoryBloc.state.events!.isNotEmpty
                          ? ListView.builder(
                              itemCount: addStoryBloc.state.events!.length,
                              itemBuilder: ((contextListView, index) {
                                return EventItem(
                                  event: addStoryBloc.state.events![index],
                                  handlePress: (MEvent event) {
                                    Navigator.pop(context, event.copyWith());
                                  },
                                );
                              }),
                            )
                          : const Center(
                              child: Text("Not found event"),
                            ),
                    );
                  });

              addStoryBloc.selectEvent(result);
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
