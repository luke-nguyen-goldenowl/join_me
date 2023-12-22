import 'package:flutter/material.dart';

class StoryView extends StatelessWidget {
  const StoryView({super.key, required this.id});
  final String id;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Story view"),
      ),
      body: Center(
        child: Text(id),
      ),
    );
  }
}
