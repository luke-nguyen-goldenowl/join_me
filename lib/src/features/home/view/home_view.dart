import 'package:flutter/material.dart';
import 'package:myapp/gen/assets.gen.dart';
import 'package:myapp/src/router/coordinator.dart';
import 'package:myapp/widgets/appbar/app_bar_custom.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCustom(
        leading: IconButton(
          onPressed: () {
            AppCoordinator.showAccountScreen();
          },
          icon: ClipRRect(
            borderRadius: BorderRadius.circular(5.0),
            child: Assets.images.images.avatar.image(),
          ),
          iconSize: 50,
        ),
        actions: [
          IconButton(
            onPressed: () {
              AppCoordinator.showSearchScreen();
            },
            icon: const Icon(
              Icons.search,
              size: 30,
            ),
          ),
          IconButton(
            onPressed: () {
              AppCoordinator.showNotifyScreen();
            },
            icon: const Badge(
              child: Icon(
                Icons.notifications_none_rounded,
                size: 30,
              ),
            ),
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
