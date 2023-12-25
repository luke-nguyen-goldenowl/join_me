import 'package:flutter/material.dart';
import 'package:myapp/src/router/coordinator.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search view"),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
                onPressed: () {
                  AppCoordinator.showProfileOtherUser(id: '1');
                },
                child: const Text("go profile other user")),
            ElevatedButton(
                onPressed: () {
                  AppCoordinator.showEventDetails(id: '1');
                },
                child: const Text("go event detail view"))
          ],
        ),
      ),
    );
  }
}
