import 'package:flutter/material.dart';

class EditEvent extends StatelessWidget {
  const EditEvent({super.key, required this.id});
  final String id;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("edit Event view"),
      ),
      body: const Center(
        child: Column(
          children: [],
        ),
      ),
    );
  }
}
