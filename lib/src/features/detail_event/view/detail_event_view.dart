import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/src/features/detail_event/logic/detail_event_bloc.dart';
import 'package:myapp/src/features/detail_event/logic/detail_event_state.dart';
import 'package:myapp/src/features/detail_event/widget/address_event.dart';
import 'package:myapp/src/features/detail_event/widget/bottom_bar_detail_event.dart';
import 'package:myapp/src/features/detail_event/widget/description_event.dart';
import 'package:myapp/src/features/detail_event/widget/host_event.dart';
import 'package:myapp/src/features/detail_event/widget/sliver_app_bar_custom_detail_event.dart';
import 'package:myapp/src/features/detail_event/widget/time_event.dart';
import 'package:myapp/src/theme/colors.dart';

class DetailEventView extends StatelessWidget {
  const DetailEventView({super.key, required this.id});
  final String id;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => DetailEventBloc(),
      child: const DetailEventPage(),
    );
  }
}

class DetailEventPage extends StatelessWidget {
  const DetailEventPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DetailEventBloc, DetailEventState>(
        buildWhen: (previous, current) =>
            previous.indexPageImage != current.indexPageImage,
        builder: (context, state) {
          return Scaffold(
            backgroundColor: AppColors.white,
            body: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: CustomScrollView(
                    slivers: [
                      const SliverAppBarCustomDetailEvent(),
                      SliverList(
                        delegate: SliverChildListDelegate([
                          // const SizedBox(height: 10),
                          const HostEvent(),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.0),
                            child: Text(
                              "Let's play different famous board games, get together every Sunday",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          const TimeEvent(),
                          const SizedBox(height: 20),
                          const DescriptionEvent(),
                          const SizedBox(height: 20),
                          const AddressEvent()
                        ]),
                      )
                    ],
                  ),
                ),
                const BottomBarDetailEvent()
              ],
            ),
          );
        });
  }
}
