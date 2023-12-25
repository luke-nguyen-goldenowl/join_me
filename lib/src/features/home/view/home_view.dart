import 'package:flutter/material.dart';
import 'package:myapp/src/_dev/widget/dev_wrap_button.dart';
import 'package:myapp/src/router/coordinator.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const DevWrapButton(
          child: Text('Welcome'),
        ),
        leading: IconButton(
          icon: const Icon(Icons.account_circle),
          onPressed: (() {
            AppCoordinator.showAccountScreen();
          }),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: (() {
              AppCoordinator.showSearchScreen();
            }),
          ),
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: (() {
              AppCoordinator.showNotifyScreen();
            }),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                AppCoordinator.showEventDetails(id: '1');
              },
              child: const Text("go event detail screen"),
            ),
            ElevatedButton(
              onPressed: () {
                AppCoordinator.showStoryScreen(id: '1');
              },
              child: const Text("go story detail screen"),
            ),
            ElevatedButton(
              onPressed: () {
                AppCoordinator.showAddStoryScreen();
              },
              child: const Text("go add story screen"),
            )
          ],
        ),
      ),
    );
  }
}
