import 'package:flutter/material.dart';
import 'package:myapp/src/router/coordinator.dart';

class DetailEventView extends StatelessWidget {
  const DetailEventView({super.key, required this.id});
  final String id;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Event detail view"),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
                onPressed: () {
                  AppCoordinator.showProfileOtherUser(id: '1');
                },
                child: const Text("go profile other user"))
          ],
        ),
      ),
    );
  }
}
