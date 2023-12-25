import 'package:flutter/material.dart';
import 'package:myapp/src/router/coordinator.dart';

class ManageEventView extends StatelessWidget {
  const ManageEventView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Manage Event view"),
      ),
      body: Center(
        child: Column(
          children: [
            Text("List my event"),
            ElevatedButton(
                onPressed: () {
                  AppCoordinator.showManageEventDetails(id: '1');
                },
                child: const Text("go manage event detail"))
          ],
        ),
      ),
    );
  }
}
