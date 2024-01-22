import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/src/features/followed/upcoming/logic/upcoming_bloc.dart';
import 'package:myapp/src/features/followed/upcoming/logic/upcoming_state.dart';
import 'package:myapp/src/features/followed/widget/ticket.dart';
import 'package:myapp/widgets/state/state_pagination_widget.dart';

class UpcomingEventFollowedView extends StatelessWidget {
  const UpcomingEventFollowedView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UpcomingBloc, UpComingState>(
      buildWhen: (previous, current) => previous.data != current.data,
      builder: (context, state) {
        return Column(
          children: [
            Expanded(
              child: RefreshIndicator(
                onRefresh: context.read<UpcomingBloc>().refreshData,
                child: ListView.builder(
                  itemCount: state.data.data.length + 1,
                  itemBuilder: ((context, index) {
                    if (index == state.data.data.length) {
                      return Container(
                        margin: const EdgeInsets.symmetric(vertical: 20),
                        alignment: Alignment.center,
                        child: XStatePaginationWidget(
                          page: state.data,
                          loadMore: context.read<UpcomingBloc>().getData,
                          autoLoad: true,
                        ),
                      );
                    } else {
                      return Ticket(
                        event: state.data.data[index],
                      );
                    }
                  }),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
