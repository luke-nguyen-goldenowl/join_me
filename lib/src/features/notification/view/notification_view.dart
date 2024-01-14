import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/src/features/notification/logic/notify_bloc.dart';
import 'package:myapp/src/features/notification/logic/notify_state.dart';
import 'package:myapp/src/features/notification/widget/notfication_change_event.dart';
import 'package:myapp/src/features/notification/widget/notification_favorite_event.dart';
import 'package:myapp/src/features/notification/widget/notification_follow_event.dart';
import 'package:myapp/src/features/notification/widget/notification_follow_user.dart';
import 'package:myapp/src/features/notification/widget/notification_new_event.dart';
import 'package:myapp/src/network/model/notification/notification_model.dart';
import 'package:myapp/widgets/appbar/app_bar_custom.dart';
import 'package:myapp/widgets/state/state_pagination_widget.dart';

class NotificationView extends StatelessWidget {
  const NotificationView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => NotifyBloc(),
      child: BlocBuilder<NotifyBloc, NotifyState>(
        buildWhen: (previous, current) => previous.data != current.data,
        builder: (context, state) {
          return Scaffold(
            appBar: const AppBarCustom(
              title: Text("Notifications"),
            ),
            body: ListView.builder(
              itemCount: state.data.data.length + 1,
              itemBuilder: ((context, index) {
                if (index == state.data.data.length) {
                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 20),
                    alignment: Alignment.center,
                    child: XStatePaginationWidget(
                      page: state.data,
                      loadMore: context.read<NotifyBloc>().getData,
                      autoLoad: true,
                    ),
                  );
                } else {
                  switch (state.data.data[index].type) {
                    case TypeNotify.changeEvent:
                      return NotificationChangeEvent(
                        changeEvent: state.data.data[index].data,
                        dateTime: state.data.data[index].dateTime,
                      );
                    case TypeNotify.newEvent:
                      return NotificationNewEvent(
                        changeEvent: state.data.data[index].data,
                        dateTime: state.data.data[index].dateTime,
                      );
                    case TypeNotify.followEvent:
                      return NotificationFollowEvent(
                        followEvent: state.data.data[index].data,
                        dateTime: state.data.data[index].dateTime,
                      );
                    case TypeNotify.followUser:
                      return NotificationFollowUser(
                        followUser: state.data.data[index].data,
                        dateTime: state.data.data[index].dateTime,
                      );
                    case TypeNotify.favoriteEvent:
                      return NotificationFavoriteEvent(
                        followEvent: state.data.data[index].data,
                        dateTime: state.data.data[index].dateTime,
                      );
                  }
                }
              }),
            ),
          );
        },
      ),
    );
  }
}
