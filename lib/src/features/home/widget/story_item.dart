import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:gradient_borders/gradient_borders.dart';
import 'package:myapp/src/features/account/logic/account_bloc.dart';
import 'package:myapp/src/features/home/logic/story_item_bloc.dart';
import 'package:myapp/src/features/home/logic/story_item_state.dart';
import 'package:myapp/src/router/coordinator.dart';
import 'package:myapp/src/theme/colors.dart';
import 'package:myapp/widgets/image/image_network.dart';

class StoryItem extends StatelessWidget {
  const StoryItem({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StoryItemBloc, StoryItemState>(
        builder: (context, state) {
      return Container(
        padding: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          color: AppColors.white,
          border: state.stories.last.viewers
                      ?.contains(GetIt.I<AccountBloc>().state.user.id) ??
                  true
              ? Border.all(color: AppColors.grey4, width: 3)
              : const GradientBoxBorder(
                  gradient: LinearGradient(colors: AppColors.gradient),
                  width: 3,
                ),
        ),
        child: InkWell(
          onTap: () {
            AppCoordinator.showStoryScreen(id: "");
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: XImageNetwork(state.host.avatar),
          ),
        ),
      );
    });
  }
}
