import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:myapp/src/features/account/logic/account_bloc.dart';
import 'package:myapp/src/features/detail_event/logic/detail_event_bloc.dart';
import 'package:myapp/src/network/model/event/event.dart';
import 'package:myapp/src/theme/colors.dart';

class BottomBarDetailEvent extends StatelessWidget {
  const BottomBarDetailEvent({
    super.key,
    required this.event,
  });

  final MEvent? event;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: double.infinity,
      color: AppColors.white,
      alignment: Alignment.center,
      child: ElevatedButton(
        onPressed:
            context.watch<DetailEventBloc>().state.isExpiredRegisterEvent()
                ? null
                : () {
                    context.read<DetailEventBloc>().onPressedFollowEvent();
                  },
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(150, 50),
          backgroundColor: AppColors.rosyPink,
          foregroundColor: AppColors.white,
        ),
        child: Text(
          event != null &&
                  event!.followersId!
                      .contains(GetIt.I<AccountBloc>().state.user.id)
              ? "Followed"
              : "Follow Event",
          style: const TextStyle(fontSize: 15),
        ),
      ),
    );
  }
}
