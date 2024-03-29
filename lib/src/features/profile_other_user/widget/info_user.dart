import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:myapp/src/features/account/logic/account_bloc.dart';
import 'package:myapp/src/features/profile_other_user/logic/user_bloc.dart';
import 'package:myapp/src/network/model/user/user.dart';
import 'package:myapp/src/theme/colors.dart';
import 'package:myapp/widgets/image/image_network.dart';

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
            child: BlocBuilder<UserBloc, MUser>(
              buildWhen: (previous, current) =>
                  previous.avatar != current.avatar,
              builder: ((context, state) {
                return XImageNetwork(
                  state.avatar,
                  fit: BoxFit.cover,
                );
              }),
            ),
          ),
        ),
        const SizedBox(height: 10),
        BlocBuilder<UserBloc, MUser>(
          buildWhen: (previous, current) => previous.name != current.name,
          builder: ((context, state) {
            return Text(
              state.name ?? "",
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            );
          }),
        ),
        const SizedBox(height: 10),
        BlocBuilder<UserBloc, MUser>(
          buildWhen: (previous, current) =>
              !listEquals(previous.followers, current.followers),
          builder: ((context, state) {
            return Text(
              "${state.followers?.length ?? 0} Follower",
              style: const TextStyle(
                fontSize: 15,
              ),
            );
          }),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            context.read<UserBloc>().onPressedFollowHost();
          },
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(150, 50),
            backgroundColor: AppColors.rosyPink,
            foregroundColor: AppColors.white,
          ),
          child: BlocBuilder<UserBloc, MUser>(
            buildWhen: (previous, current) =>
                !listEquals(previous.followers, current.followers),
            builder: ((context, state) {
              return Text(state.followers
                          ?.contains(GetIt.I<AccountBloc>().state.user.id) ??
                      false
                  ? "Following"
                  : "Follow");
            }),
          ),
        )
      ],
    );
  }
}
