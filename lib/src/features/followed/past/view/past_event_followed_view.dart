import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/src/features/followed/past/logic/past_bloc.dart';
import 'package:myapp/src/features/followed/past/logic/past_state.dart';
import 'package:myapp/src/features/followed/widget/ticket.dart';
import 'package:myapp/widgets/state/state_pagination_widget.dart';

class PastEventFollowedView extends StatelessWidget {
  const PastEventFollowedView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PastBloc(),
      child: BlocBuilder<PastBloc, PastState>(
        buildWhen: (previous, current) => previous != current,
        builder: (context, state) {
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: state.pagination.data.length,
                  itemBuilder: ((context, index) {
                    return const Ticket();
                  }),
                ),
              ),
              XStatePaginationWidget(
                page: state.pagination,
                loadMore: context.read<PastBloc>().loadMore,
                autoLoad: true,
              )
            ],
          );
        },
      ),
    );
  }
}
