import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/src/features/profile_other_user/logic/profile_other_user_bloc.dart';
import 'package:myapp/src/features/profile_other_user/logic/profile_other_user_state.dart';
import 'package:myapp/src/features/profile_other_user/widget/event_profile_user_item.dart';
import 'package:myapp/widgets/state/state_pagination_widget.dart';

class TabViewProfileUser extends StatelessWidget {
  const TabViewProfileUser({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileOtherUserBloc, ProfileOtherUserState>(
      buildWhen: (previous, current) => previous != current,
      builder: ((context, state) {
        return TabBarView(children: [
          Expanded(
            child: ListView.builder(
              itemCount: state.paginationAttended.data.length + 1,
              itemBuilder: ((context, index) {
                return index == state.paginationAttended.data.length
                    ? XStatePaginationWidget(
                        page: state.paginationAttended,
                        loadMore: context
                            .read<ProfileOtherUserBloc>()
                            .loadMoreAttended,
                        autoLoad: true,
                      )
                    : EventProfileUserItem(
                        event: state.paginationAttended.data[index]);
              }),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: state.paginationEvents.data.length + 1,
              itemBuilder: ((context, index) {
                return index == state.paginationEvents.data.length
                    ? XStatePaginationWidget(
                        page: state.paginationEvents,
                        loadMore:
                            context.read<ProfileOtherUserBloc>().loadMoreEvents,
                        autoLoad: true,
                      )
                    : EventProfileUserItem(
                        event: state.paginationEvents.data[index]);
              }),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: state.paginationFavorites.data.length + 1,
              itemBuilder: ((context, index) {
                return index == state.paginationFavorites.data.length
                    ? XStatePaginationWidget(
                        page: state.paginationFavorites,
                        loadMore: context
                            .read<ProfileOtherUserBloc>()
                            .loadMoreFavorites,
                        autoLoad: true,
                      )
                    : EventProfileUserItem(
                        event: state.paginationFavorites.data[index]);
              }),
            ),
          ),
        ]);
      }),
    );
  }
}
