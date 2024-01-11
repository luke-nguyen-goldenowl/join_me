import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/src/features/profile_other_user/logic/attended_bloc.dart';
import 'package:myapp/src/features/profile_other_user/logic/attended_state.dart';
import 'package:myapp/src/features/profile_other_user/logic/favorite_bloc.dart';
import 'package:myapp/src/features/profile_other_user/logic/favorite_state.dart';
import 'package:myapp/src/features/profile_other_user/logic/host_bloc.dart';
import 'package:myapp/src/features/profile_other_user/logic/host_state.dart';
import 'package:myapp/src/features/search/widget/event_search_widget.dart';
import 'package:myapp/src/network/model/common/pagination/pagination.dart';
import 'package:myapp/src/network/model/event/event.dart';
import 'package:myapp/widgets/state/state_pagination_widget.dart';

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

// ignore: must_be_immutable
class ListDataPaginationEvent<T> extends StatelessWidget {
  ListDataPaginationEvent({
    super.key,
    required this.data,
    required this.getData,
  });

  MPagination<T> data;
  Function() getData;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: data.data.length + 1,
            itemBuilder: ((context, index) {
              if (index == data.data.length) {
                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 20),
                  alignment: Alignment.center,
                  child: XStatePaginationWidget(
                    page: data,
                    loadMore: getData,
                    autoLoad: true,
                  ),
                );
              } else {
                return EventSearchWidget(event: data.data[index] as MEvent);
              }
            }),
          ),
        ),
      ],
    );
  }
}
