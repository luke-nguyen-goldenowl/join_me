import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gradient_borders/gradient_borders.dart';
import 'package:myapp/gen/assets.gen.dart';
import 'package:myapp/src/features/home/logic/story_item_bloc.dart';
import 'package:myapp/src/features/home/logic/story_item_state.dart';
import 'package:myapp/src/router/coordinator.dart';
import 'package:myapp/src/theme/colors.dart';

class StoryItem extends StatelessWidget {
  const StoryItem({super.key, required this.id});
  final String id;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StoryItemBloc, StoryItemState>(
        builder: (context, state) {
      return Container(
        // width: 60,
        padding: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          color: AppColors.white,
          border: !state.isView
              ? const GradientBoxBorder(
                  gradient: LinearGradient(colors: AppColors.gradient),
                  width: 3,
                )
              : Border.all(color: AppColors.grey4, width: 3),
        ),
        child: InkWell(
          onTap: () {
            if (!state.isView) context.read<StoryItemBloc>().setIsView();
            AppCoordinator.showStoryScreen(id: id);
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Assets.images.images.avatar.image(),
          ),
        ),
      );
    });
  }
}
