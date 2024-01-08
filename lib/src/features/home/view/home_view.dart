import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:myapp/gen/assets.gen.dart';
import 'package:myapp/src/features/account/logic/account_bloc.dart';
import 'package:myapp/src/features/home/logic/home_state.dart';
import 'package:myapp/src/features/home/widget/list_event_home.dart';
import 'package:myapp/src/features/home/widget/list_story_home.dart';
import 'package:myapp/src/router/coordinator.dart';
import 'package:myapp/src/theme/colors.dart';
import 'package:myapp/widgets/appbar/app_bar_custom.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return const HomePage();
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                "Hi, ${GetIt.I<AccountBloc>().state.user.name.toString()}!",
                style: const TextStyle(
                  color: AppColors.black,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              const ListStoryHome(),
              const SizedBox(height: 10),
              const ListEventHome(type: TypeListEventHome.popular),
              const SizedBox(height: 10),
              const ListEventHome(type: TypeListEventHome.upcoming),
              const SizedBox(height: 10),
              const ListEventHome(type: TypeListEventHome.people),
              const SizedBox(height: 10),
              const ListEventHome(type: TypeListEventHome.followed),
            ],
          ),
        ),
      ),
    );
  }
}
