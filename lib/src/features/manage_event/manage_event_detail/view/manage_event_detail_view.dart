import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/gen/assets.gen.dart';
import 'package:myapp/src/features/detail_event/widget/address_event.dart';

import 'package:myapp/src/features/detail_event/widget/description_event.dart';
import 'package:myapp/src/features/detail_event/widget/sliver_app_bar_custom_detail_event.dart';

import 'package:myapp/src/features/manage_event/manage_event_detail/logic/manage_event_detail_bloc.dart';
import 'package:myapp/src/features/manage_event/manage_event_detail/logic/manage_event_detail_state.dart';
import 'package:myapp/src/features/manage_event/manage_event_detail/widget/time_event_manage_event_detail.dart';
import 'package:myapp/src/network/data/event/event_repository_mock.dart';
import 'package:myapp/src/router/coordinator.dart';
import 'package:myapp/src/theme/colors.dart';

class ManageEventDetailView extends StatelessWidget {
  const ManageEventDetailView({super.key, required this.id});
  final String id;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ManageEventDetailBloc(),
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
                // BlocBuilder<ManageEventDetailBloc, ManageEventDetailState>(
                //   buildWhen: (previous, current) =>
                //       previous.indexPageImage != current.indexPageImage,
                //   builder: ((context, state) {
                //     return SliverAppBarCustomDetailEvent(
                //       indexPageImage: state.indexPageImage,
                //       images: listImage,
                //       controller:
                //           context.read<ManageEventDetailBloc>().controller,
                //       setIndexPageImage: context
                //           .read<ManageEventDetailBloc>()
                //           .setIndexPageImage,
                //     );
                //   }),
                // ),
                SliverList(
                  delegate: SliverChildListDelegate([
                    const SizedBox(height: 20),
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
                    const TimeEventMangeEventDetail(),
                    const SizedBox(height: 20),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: Text(
                        "17/20 people",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 80,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: 15,
                          itemBuilder: ((context, index) {
                            return Container(
                              margin: const EdgeInsets.symmetric(
                                horizontal: 10,
                              ),
                              width: 50,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 50,
                                    width: 50,
                                    padding: const EdgeInsets.all(2),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(18),
                                      color: AppColors.white,
                                    ),
                                    child: InkWell(
                                      onTap: () {},
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(12),
                                        child:
                                            Assets.images.images.avatar.image(),
                                      ),
                                    ),
                                  ),
                                  const Text(
                                    'Keith',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  )
                                ],
                              ),
                            );
                          })),
                    ),
                    const SizedBox(height: 20),
                    const DescriptionEvent(),
                    const SizedBox(height: 20),
                    const AddressEvent()
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
                AppCoordinator.showEditEventScreen(id: id);
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
