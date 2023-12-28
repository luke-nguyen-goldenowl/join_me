import 'package:flutter/material.dart';
import 'package:myapp/widgets/appbar/app_bar_custom.dart';

class NotificationView extends StatelessWidget {
  const NotificationView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: AppBarCustom(
        title: "Notifications",
      ),
      body: Column(
        children: [],
      ),
    );
  }
}
