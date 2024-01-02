import 'package:flutter/material.dart';
import 'package:myapp/src/theme/colors.dart';

class IndicatorImageList extends StatelessWidget {
  const IndicatorImageList({
    super.key,
    required this.isActive,
  });

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      height: isActive ? 10 : 5,
      width: isActive ? 10 : 5,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isActive ? AppColors.white : AppColors.grey2,
      ),
    );
  }
}
