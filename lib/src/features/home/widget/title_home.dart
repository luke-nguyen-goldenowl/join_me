import 'package:flutter/material.dart';
import 'package:myapp/src/theme/colors.dart';

class TitleHome extends StatelessWidget {
  const TitleHome({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: AppColors.text,
      ),
    );
  }
}
