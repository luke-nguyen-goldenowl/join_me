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
import 'package:myapp/src/network/model/user/user.dart';
import 'package:myapp/src/theme/colors.dart';

class DetailEventView extends StatelessWidget {
  const DetailEventView({super.key, required this.id});
  final String id;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => DetailEventBloc(eventId: id),
      child: const DetailEventPage(),
    );
  }
}

class DetailEventPage extends StatelessWidget {
  const DetailEventPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DetailEventBloc, DetailEventState>(
        buildWhen: (previous, current) => previous.event != current.event,
        builder: (context, state) {
          return Scaffold(
            backgroundColor: AppColors.white,
            body: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: CustomScrollView(
                    slivers: [
                      SliverAppBarCustomDetailEvent(
                        images: state.event?.images ?? [],
                        favorites: state.event?.favoritesId ?? [],
                      ),
                      SliverList(
                        delegate: SliverChildListDelegate([
                          HostEvent(user: state.event?.host ?? MUser.empty()),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Text(
                              state.event?.name ?? "",
                              textAlign: TextAlign.left,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          TimeEvent(
                            startDate: state.event?.startDate,
                            followers: state.event?.followersId!.length ?? 0,
                          ),
                          const SizedBox(height: 20),
                          DescriptionEvent(
                            description: state.event?.description ?? "",
                          ),
                          const SizedBox(height: 20),
                          AddressEvent(
                            location: state.event?.location,
                          )
                        ]),
                      )
                    ],
                  ),
                ),
                BottomBarDetailEvent(
                  event: state.event,
                )
              ],
            ),
          );
        });
  }
}
