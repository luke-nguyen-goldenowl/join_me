import 'package:flutter/material.dart';
import 'package:myapp/src/theme/colors.dart';

class BottomBarDetailEvent extends StatelessWidget {
  const BottomBarDetailEvent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: double.infinity,
      color: AppColors.white,
      alignment: Alignment.center,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(150, 50),
          backgroundColor: AppColors.rosyPink,
          foregroundColor: AppColors.white,
        ),
        child: const Text(
          "Follow Event",
          style: TextStyle(fontSize: 15),
        ),
      ),
    );
  }
}
