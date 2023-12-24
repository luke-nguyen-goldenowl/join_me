import 'package:flutter/material.dart';
import 'package:myapp/src/features/home/data/users.dart';
import 'package:myapp/src/features/home/story/widget/story_widget.dart';

class StoryView extends StatefulWidget {
  const StoryView({super.key, required this.id});
  final String id;

  @override
  State<StoryView> createState() => _StoryViewState();
}

class _StoryViewState extends State<StoryView> {
  late PageController controller;
  late final user = users.firstWhere((element) => element.id == widget.id);

  @override
  void initState() {
    super.initState();

    final initialPage = users.indexOf(user);
    controller = PageController(initialPage: initialPage);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: controller,
      onPageChanged: ((value) {
        print('chuyển page nè $value');
      }),
      children: users
          .map((user) => StoryWidget(
                user: user,
                controller: controller,
              ))
          .toList(),
    );
  }
}
