import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/src/features/account/logic/list_event_favorite_bloc.dart';
import 'package:myapp/src/features/account/logic/list_event_favorite_state.dart';
import 'package:myapp/src/features/search/widget/event_search_widget.dart';
import 'package:myapp/src/theme/colors.dart';
import 'package:myapp/widgets/state/state_pagination_widget.dart';

class ListEventFavorite extends StatelessWidget {
  const ListEventFavorite({super.key, required this.userId});
  final String userId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ListEventFavoriteBloc()..setUserId(userId),
      child: BlocBuilder<ListEventFavoriteBloc, ListEventFavoriteState>(
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
                        loadMore: context.read<ListEventFavoriteBloc>().getData,
                        autoLoad: true,
                      ),
                    );
                  } else {
                    return EventSearchWidget(
                      event: state.data.data[index],
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
