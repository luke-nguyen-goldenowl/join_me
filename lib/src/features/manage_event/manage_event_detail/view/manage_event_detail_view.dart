import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/src/features/detail_event/widget/address_event.dart';
import 'package:myapp/src/features/detail_event/widget/description_event.dart';
import 'package:myapp/src/features/detail_event/widget/sliver_app_bar_custom_detail_event.dart';
import 'package:myapp/src/features/manage_event/manage_event_detail/logic/manage_event_detail_bloc.dart';
import 'package:myapp/src/features/manage_event/manage_event_detail/logic/manage_event_detail_state.dart';
import 'package:myapp/src/features/manage_event/manage_event_detail/widget/list_follower_event.dart';
import 'package:myapp/src/features/manage_event/manage_event_detail/widget/time_event_manage_event_detail.dart';
import 'package:myapp/src/theme/colors.dart';

class ManageEventDetailView extends StatelessWidget {
  const ManageEventDetailView({super.key, required this.id});
  final String id;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ManageEventDetailBloc(eventId: id),
      child: ManageEventDetailPage(
        id: id,
      ),
    );
  }
}

class ManageEventDetailPage extends StatelessWidget {
  const ManageEventDetailPage({super.key, required this.id});

  final String id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: CustomScrollView(
              slivers: [
                BlocBuilder<ManageEventDetailBloc, ManageEventDetailState>(
                  buildWhen: (previous, current) =>
                      previous.indexPageImage != current.indexPageImage ||
                      !listEquals(previous.event.images, current.event.images),
                  builder: ((context, state) {
                    return SliverAppBarCustomDetailEvent(
                      leading: IconButton(
                          onPressed: () {
                            context.read<ManageEventDetailBloc>().backScreen();
                          },
                          icon: const Icon(Icons.arrow_back)),
                      indexPageImage: state.indexPageImage,
                      images: state.event.images ?? [],
                      controller:
                          context.read<ManageEventDetailBloc>().controller,
                      setIndexPageImage: context
                          .read<ManageEventDetailBloc>()
                          .setIndexPageImage,
                    );
                  }),
                ),
                SliverList(
                  delegate: SliverChildListDelegate([
                    const SizedBox(height: 20),
                    BlocBuilder<ManageEventDetailBloc, ManageEventDetailState>(
                      buildWhen: (previous, current) =>
                          previous.event.name != current.event.name,
                      builder: ((context, state) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Text(
                            state.event.name ?? "",
                            textAlign: TextAlign.left,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: AppColors.text,
                            ),
                          ),
                        );
                      }),
                    ),
                    const SizedBox(height: 20),
                    const TimeEventMangeEventDetail(),
                    const SizedBox(height: 20),
                    const ListAttendee(),
                    const SizedBox(height: 20),
                    BlocBuilder<ManageEventDetailBloc, ManageEventDetailState>(
                      buildWhen: (previous, current) =>
                          previous.event.description !=
                          current.event.description,
                      builder: ((context, state) {
                        return DescriptionEvent(
                          description: state.event.description ?? "",
                        );
                      }),
                    ),
                    const SizedBox(height: 20),
                    BlocBuilder<ManageEventDetailBloc, ManageEventDetailState>(
                      buildWhen: (previous, current) =>
                          previous.event != current.event,
                      builder: ((context, state) {
                        return AddressEvent(
                          location: state.event.location,
                          onMapCreate:
                              context.read<ManageEventDetailBloc>().onMapCreate,
                        );
                      }),
                    ),
                  ]),
                )
              ],
            ),
          ),
          Container(
            height: 80,
            width: double.infinity,
            color: AppColors.white,
            alignment: Alignment.center,
            child: ElevatedButton(
              onPressed: () {
                context.read<ManageEventDetailBloc>().goEditEvent(id);
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(150, 50),
                backgroundColor: AppColors.rosyPink,
                foregroundColor: AppColors.white,
              ),
              child: const Text(
                "Edit",
                style: TextStyle(fontSize: 15),
              ),
            ),
          )
        ],
      ),
    );
  }
}
