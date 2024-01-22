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
        buildWhen: (previous, current) => previous.data != current.data,
        builder: (context, state) {
          return Scaffold(
            backgroundColor: AppColors.white,
            appBar: const AppBarCustom(
              title: Text("My Events"),
            ),
            body: Column(
              children: [
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: context.read<ManageEventBloc>().refreshData,
                    child: ListView.builder(
                      itemCount: state.data.data.length + 1,
                      itemBuilder: ((context, index) {
                        if (index == state.data.data.length) {
                          return Container(
                            margin: const EdgeInsets.symmetric(vertical: 20),
                            alignment: Alignment.center,
                            child: XStatePaginationWidget(
                              page: state.data,
                              loadMore: context.read<ManageEventBloc>().getData,
                              autoLoad: true,
                            ),
                          );
                        } else {
                          return ManageEventItem(event: state.data.data[index]);
                        }
                      }),
                    ),
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
