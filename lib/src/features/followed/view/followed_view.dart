import 'package:flutter/material.dart';
import 'package:myapp/src/router/coordinator.dart';

class FollowedHomeView extends StatelessWidget {
  const FollowedHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Followed view")),
      body: Column(
        children: [
          Text("List event upcoming"),
          Text("List event past"),
          ElevatedButton(
              onPressed: () {
                AppCoordinator.showEventDetails(id: 'uWbVA0CkBqVxhYZ5QHYT');
              },
              child: const Text("go detail event"))
        ],
      ),
    );
  }
}
