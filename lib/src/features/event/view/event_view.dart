import 'package:flutter/material.dart';
import 'package:myapp/src/router/coordinator.dart';

class EventHomeView extends StatelessWidget {
  const EventHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Event screen"),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
                onPressed: () {
                  AppCoordinator.showEventDetails(id: 'uWbVA0CkBqVxhYZ5QHYT');
                },
                child: const Text("go detail event"))
          ],
        ),
      ),
    );
  }
}
