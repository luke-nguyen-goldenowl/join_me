import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:gradient_borders/gradient_borders.dart';
import 'package:myapp/src/features/account/logic/account_bloc.dart';
import 'package:myapp/src/features/home/logic/home_bloc.dart';
import 'package:myapp/src/network/model/story/story.dart';
import 'package:myapp/src/network/model/user/user.dart';
import 'package:myapp/src/theme/colors.dart';
import 'package:myapp/widgets/image/image_network.dart';

class StoryItem extends StatelessWidget {
  const StoryItem({super.key, required this.host, required this.stories});
  final MUser host;

  final List<MStory> stories;
  bool isUserIdSeenAllEvent() {
    String userId = GetIt.I<AccountBloc>().state.user.id;
    return stories.every((story) => story.viewers?.contains(userId) ?? false);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        color: AppColors.white,
        border: isUserIdSeenAllEvent()
            ? Border.all(color: AppColors.grey4, width: 3)
            : const GradientBoxBorder(
                gradient: LinearGradient(colors: AppColors.gradient),
                width: 3,
              ),
      ),
      child: InkWell(
        onTap: () {
          context.read<HomeBloc>().goStoryView(host.id);
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: XImageNetwork(
            host.avatar,
            height: 50,
            width: 50,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
