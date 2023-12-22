import 'package:flutter/material.dart';
import 'package:gradient_borders/gradient_borders.dart';
import 'package:myapp/src/router/coordinator.dart';
import 'package:myapp/src/theme/colors.dart';

class StoryItem extends StatelessWidget {
  const StoryItem({super.key, required this.id});
  final String id;
  @override
  Widget build(BuildContext context) {
    return Container(
      // width: 60,
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        color: AppColors.white,
        border: const GradientBoxBorder(
          gradient: LinearGradient(colors: AppColors.gradient),
          width: 3,
        ),
      ),
      child: InkWell(
        onTap: () {
          AppCoordinator.showStoryScreen(id: id);
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.asset("assets/images/images/avatar.png"),
        ),
      ),
    );
  }
}
