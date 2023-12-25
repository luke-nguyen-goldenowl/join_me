import 'package:flutter/material.dart';
import 'package:myapp/src/router/coordinator.dart';
import 'package:myapp/src/theme/colors.dart';

class CustomFloatingActionButton extends StatelessWidget {
  const CustomFloatingActionButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        AppCoordinator.showAddEventScreen();
      },
      elevation: 0,
      backgroundColor: AppColors.rosyPink,
      shape: RoundedRectangleBorder(
        side: const BorderSide(
          width: 5,
          color: AppColors.white,
          style: BorderStyle.solid,
        ),
        borderRadius: BorderRadius.circular(100),
      ),
      child: const Icon(
        Icons.add,
        color: AppColors.white,
      ),
    );
  }
}
