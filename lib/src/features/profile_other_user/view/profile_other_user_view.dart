import 'package:flutter/material.dart';

class ProfileOtherUserView extends StatelessWidget {
  const ProfileOtherUserView({super.key, required this.id});
  final String id;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile other user view"),
      ),
      body: const Center(
        child: Column(
          children: [],
        ),
      ),
    );
  }
}
