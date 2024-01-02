import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/src/features/profile_other_user/logic/profile_other_user_bloc.dart';
import 'package:myapp/src/features/profile_other_user/widget/info_user.dart';
import 'package:myapp/src/features/profile_other_user/widget/tab_view_profile_user.dart';
import 'package:myapp/src/theme/colors.dart';
import 'package:myapp/widgets/appbar/app_bar_custom.dart';

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
