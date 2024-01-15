import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/src/features/manage_event/manage_event_detail/logic/manage_event_detail_bloc.dart';
import 'package:myapp/src/features/manage_event/manage_event_detail/logic/manage_event_detail_state.dart';
import 'package:myapp/src/router/coordinator.dart';

import 'package:myapp/src/theme/colors.dart';
import 'package:myapp/widgets/image/image_network.dart';

class ListAttendee extends StatelessWidget {
  const ListAttendee({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ManageEventDetailBloc, ManageEventDetailState>(
      buildWhen: (previous, current) =>
          previous.followers.length != current.followers.length,
      builder: ((context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                "${state.followers.length} people",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: 80,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: state.followers.length,
                  itemBuilder: ((context, index) {
                    return InkWell(
                      onTap: () {
                        AppCoordinator.showProfileOtherUser(
                            id: state.followers[index].id);
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 10,
                        ),
                        width: 60,
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
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: XImageNetwork(
                                  state.followers[index].avatar,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Text(
                              state.followers[index].name ?? "",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            )
                          ],
                        ),
                      ),
                    );
                  })),
            ),
          ],
        );
      }),
    );
  }
}
