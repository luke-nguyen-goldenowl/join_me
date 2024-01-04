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
          return Expanded(
            child: ListView.builder(
              itemCount: state.data.data.length + 1,
              itemBuilder: ((context, index) {
                if (index == state.data.data.length) {
                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 20),
                    alignment: Alignment.center,
                    child: XStatePaginationWidget(
                      page: state.data,
                      loadMore: context.read<PastBloc>().getData,
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
          );
        },
      ),
    );
  }
}
