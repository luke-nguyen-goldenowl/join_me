import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/src/features/notification/logic/notify_bloc.dart';
import 'package:myapp/src/features/notification/logic/notify_state.dart';
import 'package:myapp/src/features/notification/widget/notfication_change_event.dart';
import 'package:myapp/src/features/notification/widget/notifcation_upcoming_event.dart';
import 'package:myapp/src/features/notification/widget/notification_follow_event.dart';
import 'package:myapp/src/features/notification/widget/notification_follow_user.dart';
import 'package:myapp/src/network/data/notification/notification_repository_mock.dart';
import 'package:myapp/widgets/appbar/app_bar_custom.dart';

class NotificationView extends StatelessWidget {
  const NotificationView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => NotifyBloc()..getNotifies(),
      child: BlocBuilder<NotifyBloc, NotifyState>(
        buildWhen: (previous, current) => previous != current,
        builder: (context, state) {
          return Scaffold(
            appBar: const AppBarCustom(
              title: "Notifications",
            ),
            body: ListView.builder(
              itemCount: state.notifies.length,
              itemBuilder: ((context, index) {
                switch (state.notifies[index].type) {
                  case TypeNotify.changeEvent:
                    return NotificationChangeEvent(
                        changeEvent: state.notifies[index].data);

                  case TypeNotify.followEvent:
                    return NotificationFollowEvent(
                        followEvent: state.notifies[index].data);
                  case TypeNotify.followUser:
                    return NotificationFollowUser(
                        followUser: state.notifies[index].data);

                  case TypeNotify.upcomingEvent:
                    return NotificationUpcomingEvent(
                        upcomingEvent: state.notifies[index].data);
                }
              }),
            ),
          );
        },
      ),
    );
  }
}
