import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/src/features/profile_other_user/logic/attended_bloc.dart';
import 'package:myapp/src/features/profile_other_user/logic/favorite_bloc.dart';
import 'package:myapp/src/features/profile_other_user/logic/host_bloc.dart';
import 'package:myapp/src/features/profile_other_user/logic/user_bloc.dart';
import 'package:myapp/src/features/profile_other_user/widget/info_user.dart';
import 'package:myapp/src/features/profile_other_user/widget/tab_view_profile_user.dart';
import 'package:myapp/src/theme/colors.dart';
import 'package:myapp/widgets/appbar/app_bar_custom.dart';

class ProfileOtherUserView extends StatelessWidget {
  const ProfileOtherUserView({super.key, required this.id});
  final String id;
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(create: (_) => UserBloc(userId: id)),
      BlocProvider(create: (_) => AttendedBloc(userId: id)),
      BlocProvider(create: (_) => HostBloc(userId: id)),
      BlocProvider(create: (_) => FavoriteBloc(userId: id)),
    ], child: const ProfileOtherUserPage());
  }
}

class ProfileOtherUserPage extends StatelessWidget {
  const ProfileOtherUserPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBarCustom(),
      body: DefaultTabController(
        length: 3,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            InfoUser(),
            SizedBox(height: 20),
            TabBar(tabs: [
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
            SizedBox(height: 10),
            Expanded(
              child: TabViewProfileUser(),
            )
          ],
        ),
      ),
    );
  }
}
