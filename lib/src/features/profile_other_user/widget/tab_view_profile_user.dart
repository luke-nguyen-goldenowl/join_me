import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/src/features/profile_other_user/logic/attended_bloc.dart';
import 'package:myapp/src/features/profile_other_user/logic/attended_state.dart';
import 'package:myapp/src/features/profile_other_user/logic/favorite_bloc.dart';
import 'package:myapp/src/features/profile_other_user/logic/favorite_state.dart';
import 'package:myapp/src/features/profile_other_user/logic/host_bloc.dart';
import 'package:myapp/src/features/profile_other_user/logic/host_state.dart';
import 'package:myapp/src/features/profile_other_user/widget/list_data_paination_event.dart';

class TabViewProfileUser extends StatelessWidget {
  const TabViewProfileUser({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TabBarView(children: [
      BlocBuilder<AttendedBloc, AttendedState>(
        buildWhen: (previous, current) => previous.data != current.data,
        builder: ((context, state) {
          return ListDataPaginationEvent(
            data: state.data,
            getData: context.read<AttendedBloc>().getData,
          );
        }),
      ),
      BlocBuilder<HostBloc, HostState>(
        buildWhen: (previous, current) => previous.data != current.data,
        builder: ((context, state) {
          return ListDataPaginationEvent(
            data: state.data,
            getData: context.read<HostBloc>().getData,
          );
        }),
      ),
      BlocBuilder<FavoriteBloc, FavoriteState>(
        buildWhen: (previous, current) => previous.data != current.data,
        builder: ((context, state) {
          return ListDataPaginationEvent(
            data: state.data,
            getData: context.read<FavoriteBloc>().getData,
          );
        }),
      ),
    ]);
  }
}
