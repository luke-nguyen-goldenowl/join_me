import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/src/features/manage_event/logic/manage_event_bloc.dart';
import 'package:myapp/src/features/manage_event/logic/manage_event_state.dart';
import 'package:myapp/src/features/manage_event/widget/manage_event_item.dart';
import 'package:myapp/src/theme/colors.dart';
import 'package:myapp/widgets/appbar/app_bar_custom.dart';
import 'package:myapp/widgets/state/state_pagination_widget.dart';

class ManageEventView extends StatelessWidget {
  const ManageEventView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ManageEventBloc(),
      child: BlocBuilder<ManageEventBloc, ManageEventState>(
        buildWhen: (previous, current) => previous != current,
        builder: (context, state) {
          return Scaffold(
            backgroundColor: AppColors.white,
            appBar: const AppBarCustom(
              title: "My Events",
            ),
            body: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: state.pagination.data.length + 1,
                    itemBuilder: ((context, index) {
                      return index == state.pagination.data.length
                          ? XStatePaginationWidget(
                              page: state.pagination,
                              loadMore:
                                  context.read<ManageEventBloc>().loadMore,
                              autoLoad: true,
                            )
                          : ManageEventItem(
                              event: state.pagination.data[index]);
                    }),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
