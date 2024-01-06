import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myapp/src/dialogs/widget/bottom_sheet.dart';
import 'package:myapp/src/features/home/story/logic/add_story_bloc.dart';
import 'package:myapp/src/features/home/story/widget/event_item_story.dart';
import 'package:myapp/src/network/model/event/event.dart';
import 'package:myapp/src/theme/colors.dart';

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
              final result = await XBottomSheet.showCustomBottomSheet<MEvent>(
                context: context,
                backgroundColor: AppColors.iceBlue,
                builder: (contextModal) {
                  return _buildBottomSheetWidget(addStoryBloc, context);
                },
              );
              addStoryBloc.selectEvent(result);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildBottomSheetWidget(
      AddStoryBloc addStoryBloc, BuildContext context) {
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
