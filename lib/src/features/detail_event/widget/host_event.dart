// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:myapp/src/features/account/logic/account_bloc.dart';
import 'package:myapp/src/features/detail_event/logic/detail_event_bloc.dart';
import 'package:myapp/src/network/model/user/user.dart';
import 'package:myapp/src/router/coordinator.dart';
import 'package:myapp/src/theme/colors.dart';

class HostEvent extends StatelessWidget {
  const HostEvent({
    super.key,
    required this.user,
  });
  final MUser user;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        AppCoordinator.showProfileOtherUser(id: user.id);
      },
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                if (user.avatar != null)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      user.avatar!,
                      height: 50,
                      width: 50,
                      fit: BoxFit.cover,
                    ),
                  ),
                const SizedBox(width: 10),
                Text(
                  user.name ?? "",
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
            SizedBox(
              height: 35,
              width: 120,
              child: ElevatedButton(
                onPressed: GetIt.I<AccountBloc>().state.user.id != user.id
                    ? () {
                        context.read<DetailEventBloc>().onPressedFollowHost();
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: AppColors.rosyPink.withOpacity(0.1),
                  foregroundColor: AppColors.rosyPink,
                ),
                child: Text(
                  user.followers != null &&
                          user.followers!
                              .contains(GetIt.I<AccountBloc>().state.user.id)
                      ? "Following"
                      : "Follow",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
