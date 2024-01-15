import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:myapp/src/features/account/logic/list_following_bloc.dart';
import 'package:myapp/src/features/account/logic/list_following_state.dart';

import 'package:myapp/src/features/search/widget/person_search_widget.dart';
import 'package:myapp/src/theme/colors.dart';

class ListFollowing extends StatelessWidget {
  const ListFollowing({super.key, required this.userId});
  final String userId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ListFollowingBloc(),
      child: BlocBuilder<ListFollowingBloc, ListFollowingState>(
        buildWhen: (previous, current) =>
            !listEquals(previous.followings, current.followings),
        builder: ((context, state) {
          return Column(
            children: [
              Expanded(
                child: Container(
                  color: AppColors.white,
                  child: ListView.builder(
                    itemCount: state.followings.length,
                    itemBuilder: ((context, index) {
                      return PersonSearchWidget(
                        person: state.followings[index],
                      );
                    }),
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
