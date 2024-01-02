import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:myapp/src/features/account/logic/account_bloc.dart';
import 'package:myapp/src/features/account/widget/info_user.dart';
import 'package:myapp/src/features/account/widget/list_event_favorite.dart';
import 'package:myapp/src/features/account/widget/list_follower.dart';
import 'package:myapp/src/router/coordinator.dart';
import 'package:myapp/src/theme/colors.dart';
import 'package:myapp/widgets/appbar/app_bar_custom.dart';

class AccountHomeView extends StatelessWidget {
  const AccountHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    const space = SizedBox(height: 15);
    return BlocBuilder<AccountBloc, AccountState>(
        builder: (context, AccountState state) {
      return Scaffold(
        backgroundColor: AppColors.grey6,
        appBar: AppBarCustom(
          actions: [
            IconButton(
                onPressed: () {
                  AppCoordinator.showProfile();
                },
                icon: const Icon(Icons.more_vert))
          ],
        ),
        body: DefaultTabController(
          length: 2,
          child: Column(
            children: [
              space,
              InfoUser(user: state.user),
              space,
              Container(
                color: AppColors.white,
                child: const TabBar(tabs: [
                  Tab(
                    text: "Favorite events",
                  ),
                  Tab(
                    text: "Follower",
                  ),
                ]),
              ),
              Expanded(
                child: TabBarView(children: [
                  ListEventFavorite(
                    userId: state.user.id,
                  ),
                  ListFollower(
                    userId: state.user.id,
                  ),
                ]),
              )
            ],
          ),
        ),
      );
    });
  }
}
