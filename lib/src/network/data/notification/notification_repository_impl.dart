import 'package:myapp/src/network/data/notification/notification_reference.dart';
import 'package:myapp/src/network/model/common/result.dart';
import 'package:myapp/src/network/model/event/event.dart';
import 'package:myapp/src/network/model/notification/notification_model.dart';
import 'package:myapp/src/network/model/user/user.dart';

class NotificationRepositoryImpl {
  NotificationReference notificationReference = NotificationReference();

  Future<MResult<NotificationModel>> sendNotificationFollowEvent(
      MEvent event, MUser user) async {
    try {
      final result =
          await notificationReference.sendNotificationFollowEvent(event, user);
      if (result.isSuccess) {
        return MResult.success(result.data);
      }
      return MResult.error(result.error);
    } catch (e) {
      return MResult.exception(e);
    }
  }

  Future<MResult<NotificationModel>> sendNotificationFavoriteEvent(
      MEvent event, MUser user) async {
    try {
      final result = await notificationReference.sendNotificationFavoriteEvent(
          event, user);
      if (result.isSuccess) {
        return MResult.success(result.data);
      }
      return MResult.error(result.error);
    } catch (e) {
      return MResult.exception(e);
    }
  }

  Future<MResult<NotificationModel>> sendNotificationFollowUser(
      MUser host, MUser follower) async {
    try {
      final result = await notificationReference.sendNotificationFollowUser(
          host, follower);
      if (result.isSuccess) {
        return MResult.success(result.data);
      }
      return MResult.error(result.error);
    } catch (e) {
      return MResult.exception(e);
    }
  }

  Future<MResult<NotificationModel>> sendNotificationChangeEvent(
      MEvent event) async {
    try {
      final result =
          await notificationReference.sendNotificationChangeEvent(event);
      if (result.isSuccess) {
        return MResult.success(result.data);
      }
      return MResult.error(result.error);
    } catch (e) {
      return MResult.exception(e);
    }
  }

  Future<MResult<NotificationModel>> sendNotificationNewEvent(
      MEvent event) async {
    try {
      final result =
          await notificationReference.sendNotificationNewEvent(event);
      if (result.isSuccess) {
        return MResult.success(result.data);
      }
      return MResult.error(result.error);
    } catch (e) {
      return MResult.exception(e);
    }
  }

  Future<MResult<List<NotificationModel>>> getNotification(String hostId,
      [NotificationModel? lastNotification]) async {
    try {
      final result =
          await notificationReference.getNotification(hostId, lastNotification);
      if (result.isSuccess) {
        return MResult.success(result.data);
      }
      return MResult.error(result.error);
    } catch (e) {
      return MResult.exception(e);
    }
  }

  Future<MResult<int>> getCountNotification(
    String hostId,
  ) async {
    try {
      final result = await notificationReference.getCountNotification(hostId);
      if (result.isSuccess) {
        return MResult.success(result.data);
      }
      return MResult.error(result.error);
    } catch (e) {
      return MResult.exception(e);
    }
  }

  Future<MResult<int>> getCountNotificationNotSeen(
    String hostId,
  ) async {
    try {
      final result =
          await notificationReference.getCountNotificationNotSeen(hostId);
      if (result.isSuccess) {
        return MResult.success(result.data);
      }
      return MResult.error(result.error);
    } catch (e) {
      return MResult.exception(e);
    }
  }
}
