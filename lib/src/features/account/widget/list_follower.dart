import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:myapp/src/features/account/logic/list_follower_bloc.dart';
import 'package:myapp/src/features/account/logic/list_follower_state.dart';

import 'package:myapp/src/features/account/widget/follower.dart';
import 'package:myapp/src/theme/colors.dart';
import 'package:myapp/widgets/state/state_pagination_widget.dart';

class ListFollower extends StatelessWidget {
  const ListFollower({super.key, required this.userId});
  final String userId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ListFollowerBloc()..setUserId(userId),
      child: BlocBuilder<ListFollowerBloc, ListFollowerState>(
        buildWhen: (previous, current) =>
            previous.userId != current.userId || previous.data != current.data,
        builder: ((context, state) {
          return Expanded(
            child: Container(
              color: AppColors.white,
              child: ListView.builder(
                itemCount: state.data.data.length + 1,
                itemBuilder: ((context, index) {
                  if (index == state.data.data.length) {
                    return Container(
                      margin: const EdgeInsets.symmetric(vertical: 20),
                      alignment: Alignment.center,
                      child: XStatePaginationWidget(
                        page: state.data,
                        loadMore: context.read<ListFollowerBloc>().getData,
                        autoLoad: true,
                      ),
                    );
                  } else {
                    return Follower(
                      person: state.data.data[index],
                    );
                  }
                }),
              ),
            ),
          );
        }),
      ),
    );
  }
}
