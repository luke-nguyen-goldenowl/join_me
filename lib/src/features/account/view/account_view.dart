import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:myapp/src/features/account/logic/account_bloc.dart';
import 'package:myapp/src/features/account/logic/list_event_favorite_bloc.dart';
import 'package:myapp/src/features/account/logic/list_follower_bloc.dart';
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
    const space = SizedBox(height: 10);
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ListEventFavoriteBloc()),
        BlocProvider(create: (_) => ListFollowerBloc())
      ],
      child: const AccountHomePage(space: space),
    );
  }
}

class AccountHomePage extends StatelessWidget {
  const AccountHomePage({
    super.key,
    required this.space,
  });

  final SizedBox space;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccountBloc, AccountState>(
        buildWhen: (previous, current) => previous.user != current.user,
        builder: (context, AccountState state) {
          return Scaffold(
            backgroundColor: AppColors.grey6,
            appBar: AppBarCustom(
              title: const Text("Profile"),
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
