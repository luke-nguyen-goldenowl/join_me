import 'package:flutter/material.dart';
import 'package:myapp/src/router/coordinator.dart';

class ManageEventDetailView extends StatelessWidget {
  const ManageEventDetailView({super.key, required this.id});
  final String id;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Manage Event detail view"),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
                onPressed: () {
                  AppCoordinator.showEditEventScreen(id: '1');
                },
                child: const Text("go edit event "))
          ],
        ),
      ),
    );
  }
}
