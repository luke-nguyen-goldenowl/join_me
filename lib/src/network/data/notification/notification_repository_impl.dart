import 'package:myapp/src/network/data/notification/notification_reference.dart';
import 'package:myapp/src/network/model/common/pagination/pagination_response.dart';
import 'package:myapp/src/network/model/common/result.dart';
import 'package:myapp/src/network/model/event/event.dart';
import 'package:myapp/src/network/model/notification/notification_model.dart';
import 'package:myapp/src/network/model/user/user.dart';

class NotificationRepositoryImpl {
  NotificationReference notificationReference = NotificationReference();

  Future<MResult<NotificationModel>> sendNotificationFollowEvent(
      MEvent event, MUser user) {
    return notificationReference.sendNotificationFollowEvent(event, user);
  }

  Future<MResult<NotificationModel>> sendNotificationFavoriteEvent(
      MEvent event, MUser user) {
    return notificationReference.sendNotificationFavoriteEvent(event, user);
  }

  Future<MResult<NotificationModel>> sendNotificationFollowUser(
      MUser host, MUser follower) {
    return notificationReference.sendNotificationFollowUser(host, follower);
  }

  Future<MResult<NotificationModel>> sendNotificationChangeEvent(MEvent event) {
    return notificationReference.sendNotificationChangeEvent(event);
  }

  Future<MResult<NotificationModel>> sendNotificationNewEvent(MEvent event) {
    return notificationReference.sendNotificationNewEvent(event);
  }

  Future<MResult<MPaginationResponse<NotificationModel>>> getNotification(
      String hostId,
      [NotificationModel? lastNotification]) {
    return notificationReference.getNotification(hostId, lastNotification);
  }

  Future<MResult<int>> getCountNotification(
    String hostId,
  ) {
    return notificationReference.getCountNotification(hostId);
  }

  Future<MResult<int>> getCountNotificationNotSeen(
    String hostId,
  ) {
    return notificationReference.getCountNotificationNotSeen(hostId);
  }
}
