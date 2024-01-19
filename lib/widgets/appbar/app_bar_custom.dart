import 'package:flutter/material.dart';
import 'package:myapp/src/theme/colors.dart';

class AppBarCustom extends StatelessWidget implements PreferredSizeWidget {
  const AppBarCustom(
      {super.key, this.actions, this.leading, this.title, this.bottom});

  final Widget? leading;
  final List<Widget>? actions;
  final Widget? title;
  final PreferredSizeWidget? bottom;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.white,
      title: title,
      titleTextStyle: const TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: AppColors.text,
      ),
      centerTitle: true,
      leading: leading,
      actions: actions,
      bottom: bottom,
    );
  }

  @override
  Size get preferredSize =>
      Size.fromHeight(bottom == null ? kToolbarHeight : 80);
}
