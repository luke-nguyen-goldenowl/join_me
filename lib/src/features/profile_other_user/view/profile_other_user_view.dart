import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:myapp/gen/assets.gen.dart';
import 'package:myapp/src/features/profile_other_user/logic/profile_other_user_bloc.dart';
import 'package:myapp/src/features/profile_other_user/logic/profile_other_user_state.dart';
import 'package:myapp/src/features/profile_other_user/widget/event_profile_user_item.dart';
import 'package:myapp/src/theme/colors.dart';
import 'package:myapp/widgets/appbar/app_bar_custom.dart';
import 'package:myapp/widgets/state/state_pagination_widget.dart';

class ProfileOtherUserView extends StatelessWidget {
  const ProfileOtherUserView({super.key, required this.id});
  final String id;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProfileOtherUserBloc(),
      child: ProfileOtherUserPage(
        id: id,
      ),
    );
  }
}

class ProfileOtherUserPage extends StatelessWidget {
  const ProfileOtherUserPage({
    required this.id,
    super.key,
  });
  final String id;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: const AppBarCustom(),
      body: DefaultTabController(
        length: 3,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            const InfoUser(),
            const SizedBox(height: 20),
            Container(
              child: const TabBar(tabs: [
                Tab(
                  text: "Attended",
                ),
                Tab(
                  text: "Events",
                ),
                Tab(
                  text: "Favorites",
                )
              ]),
            ),
            const SizedBox(height: 10),
            const Expanded(
              child: TabViewProfileUser(),
            )
          ],
        ),
      ),
    );
  }
}

class TabViewProfileUser extends StatelessWidget {
  const TabViewProfileUser({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileOtherUserBloc, ProfileOtherUserState>(
      buildWhen: (previous, current) => previous != current,
      builder: ((context, state) {
        return TabBarView(children: [
          Expanded(
            child: ListView.builder(
              itemCount: state.paginationAttended.data.length + 1,
              itemBuilder: ((context, index) {
                return index == state.paginationAttended.data.length
                    ? XStatePaginationWidget(
                        page: state.paginationAttended,
                        loadMore: context
                            .read<ProfileOtherUserBloc>()
                            .loadMoreAttended,
                        autoLoad: true,
                      )
                    : EventProfileUserItem(
                        event: state.paginationAttended.data[index]);
              }),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: state.paginationEvents.data.length + 1,
              itemBuilder: ((context, index) {
                return index == state.paginationEvents.data.length
                    ? XStatePaginationWidget(
                        page: state.paginationEvents,
                        loadMore:
                            context.read<ProfileOtherUserBloc>().loadMoreEvents,
                        autoLoad: true,
                      )
                    : EventProfileUserItem(
                        event: state.paginationEvents.data[index]);
              }),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: state.paginationFavorites.data.length + 1,
              itemBuilder: ((context, index) {
                return index == state.paginationFavorites.data.length
                    ? XStatePaginationWidget(
                        page: state.paginationFavorites,
                        loadMore: context
                            .read<ProfileOtherUserBloc>()
                            .loadMoreFavorites,
                        autoLoad: true,
                      )
                    : EventProfileUserItem(
                        event: state.paginationFavorites.data[index]);
              }),
            ),
          ),
        ]);
      }),
    );
  }
}

class InfoUser extends StatelessWidget {
  const InfoUser({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: 80,
          width: 80,
          padding: const EdgeInsets.all(2),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              color: AppColors.white,
              border: const GradientBoxBorder(
                gradient: LinearGradient(colors: AppColors.gradient),
                width: 3,
              )),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Assets.images.images.avatar.image(),
          ),
        ),
        const SizedBox(height: 10),
        const Text(
          "Emiliano Vittorisosi",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "12 Events",
              style: TextStyle(
                fontSize: 15,
              ),
            ),
            SizedBox(width: 20),
            Text(
              "200 Follower",
              style: TextStyle(
                fontSize: 15,
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(150, 50),
            backgroundColor: AppColors.rosyPink,
            foregroundColor: AppColors.white,
          ),
          child: const Text("Follow"),
        )
      ],
    );
  }
}
