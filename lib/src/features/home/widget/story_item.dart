import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:gradient_borders/gradient_borders.dart';
import 'package:myapp/src/features/account/logic/account_bloc.dart';
import 'package:myapp/src/features/home/logic/home_bloc.dart';
import 'package:myapp/src/network/model/user/user.dart';
import 'package:myapp/src/router/coordinator.dart';
import 'package:myapp/src/theme/colors.dart';
import 'package:myapp/widgets/image/image_network.dart';

class StoryItem extends StatelessWidget {
  const StoryItem({super.key, required this.host, required this.hostIndex});
  final MUser host;
  final int hostIndex;

  bool _isUserIdSeenAllEvent() {
    String userId = GetIt.I<AccountBloc>().state.user.id;
    final stories = GetIt.I<HomeBloc>().state.userStory[hostIndex].stories;
    return stories.every((story) => story.viewers?.contains(userId) ?? false);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        color: AppColors.white,
        border: _isUserIdSeenAllEvent()
            ? Border.all(color: AppColors.grey4, width: 3)
            : const GradientBoxBorder(
                gradient: LinearGradient(colors: AppColors.gradient),
                width: 3,
              ),
      ),
      child: InkWell(
        onTap: () {
          AppCoordinator.showStoryScreen(id: host.id);
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: XImageNetwork(host.avatar),
        ),
      ),
    );
  }
}
