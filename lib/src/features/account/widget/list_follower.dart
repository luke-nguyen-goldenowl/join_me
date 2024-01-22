import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:myapp/src/features/account/logic/list_follower_bloc.dart';
import 'package:myapp/src/features/account/logic/list_follower_state.dart';

import 'package:myapp/src/features/search/widget/person_search_widget.dart';
import 'package:myapp/src/theme/colors.dart';

class ListFollower extends StatelessWidget {
  const ListFollower({super.key, required this.userId});
  final String userId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ListFollowerBloc(),
      child: BlocBuilder<ListFollowerBloc, ListFollowerState>(
        buildWhen: (previous, current) =>
            !listEquals(previous.followers, current.followers),
        builder: ((context, state) {
          return Column(
            children: [
              Expanded(
                child: Container(
                  color: AppColors.white,
                  child: RefreshIndicator(
                    onRefresh: context.read<ListFollowerBloc>().refreshData,
                    child: ListView.builder(
                      itemCount: state.followers.length,
                      itemBuilder: ((context, index) {
                        return PersonSearchWidget(
                          person: state.followers[index],
                        );
                      }),
                    ),
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
