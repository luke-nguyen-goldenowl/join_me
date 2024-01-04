import 'package:flutter/material.dart';
import 'package:myapp/src/features/followed/past/view/past_event_followed_view.dart';
import 'package:myapp/src/features/followed/upcoming/view/upcoming_event_followed_view.dart';
import 'package:myapp/src/router/coordinator.dart';
import 'package:myapp/src/theme/colors.dart';
import 'package:myapp/widgets/appbar/app_bar_custom.dart';

class FollowedHomeView extends StatelessWidget {
  const FollowedHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBarCustom(
          title: const Text("Followed"),
          actions: [
            IconButton(
              onPressed: () {
                AppCoordinator.showSearchScreen();
              },
              icon: const Icon(
                Icons.search,
                size: 30,
              ),
            )
          ],
          bottom: const TabBar(
            labelStyle: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
            unselectedLabelColor: AppColors.grey,
            tabs: [
              Tab(
                text: "Upcoming",
              ),
              Tab(
                text: "Past",
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            UpcomingEventFollowedView(),
            PastEventFollowedView(),
          ],
        ),
      ),
    );
  }
}
