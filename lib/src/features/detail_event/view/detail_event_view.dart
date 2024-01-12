import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:myapp/src/features/account/logic/account_bloc.dart';
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
                      BlocBuilder<DetailEventBloc, DetailEventState>(
                        buildWhen: (previous, current) =>
                            previous.indexPageImage != current.indexPageImage ||
                            current.event != previous.event,
                        builder: ((context, state) {
                          return SliverAppBarCustomDetailEvent(
                            leading: IconButton(
                              onPressed: () {
                                context.read<DetailEventBloc>().goBack();
                              },
                              icon: const Icon(Icons.arrow_back),
                            ),
                            indexPageImage: state.indexPageImage,
                            images: state.event?.images ?? [],
                            controller:
                                context.read<DetailEventBloc>().controller,
                            setIndexPageImage: context
                                .read<DetailEventBloc>()
                                .setIndexPageImage,
                            actions: [
                              IconButton(
                                onPressed: () {
                                  context
                                      .read<DetailEventBloc>()
                                      .onPressedFavoriteEvent();
                                },
                                icon: state.event?.favoritesId?.contains(
                                            GetIt.I<AccountBloc>()
                                                .state
                                                .user
                                                .id) ??
                                        false
                                    ? const Icon(
                                        Icons.favorite,
                                        color: AppColors.rosyPink,
                                      )
                                    : const Icon(Icons.favorite_border),
                              )
                            ],
                          );
                        }),
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
                            followers: state.event?.followersId?.length ?? 0,
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
