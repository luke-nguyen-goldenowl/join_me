import 'package:flutter/material.dart';
import 'package:myapp/src/theme/colors.dart';

class AppBarCustom extends StatelessWidget implements PreferredSizeWidget {
  const AppBarCustom({super.key, this.actions, this.leading, this.title});

  final Widget? leading;
  final List<Widget>? actions;
  final String? title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.white,
      title: Text(
        title ?? "",
      ),
      titleTextStyle: const TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: AppColors.black,
      ),
      centerTitle: true,
      leading: leading,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
