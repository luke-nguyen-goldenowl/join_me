import 'package:myapp/src/network/model/notification/notification_model.dart';

class NotifyState {
  List<NotificationModel> notifies;
  NotifyState({
    required this.notifies,
  });

  factory NotifyState.ds() {
    return NotifyState(notifies: []);
  }

  NotifyState copyWith({
    List<NotificationModel>? notifies,
  }) {
    return NotifyState(
      notifies: notifies ?? this.notifies,
    );
  }
}
