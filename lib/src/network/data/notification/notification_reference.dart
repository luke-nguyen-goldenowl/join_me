import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myapp/src/network/domain_manager.dart';
import 'package:myapp/src/network/firebase/base_collection.dart';
import 'package:myapp/src/network/model/common/pagination/pagination.dart';
import 'package:myapp/src/network/model/common/result.dart';
import 'package:myapp/src/network/model/event/event.dart';
import 'package:myapp/src/network/model/notification/change_event.dart';
import 'package:myapp/src/network/model/notification/follow_event.dart';
import 'package:myapp/src/network/model/notification/follow_user.dart';
import 'package:myapp/src/network/model/notification/notification_model.dart';
import 'package:myapp/src/network/model/user/user.dart';
import 'package:myapp/src/services/firebase_message.dart';
import 'package:http/http.dart';
import 'dart:io';

import 'package:myapp/src/utils/date/date_helper.dart';

class NotificationReference extends BaseCollectionReference<NotificationModel> {
  NotificationReference()
      : super(
          FirebaseFirestore.instance
              .collection('notifications')
              .withConverter<NotificationModel>(
                fromFirestore: (snapshot, options) => NotificationModel.fromMap(
                    snapshot.data() as Map<String, dynamic>, snapshot.id),
                toFirestore: (chatRoom, _) => chatRoom.toMap(),
              ),
          getObjectId: (e) => e.id ?? "",
          setObjectId: (e, id) => e.copyWith(id: id),
        );

  static XFirebaseMessage firebaseMessage = XFirebaseMessage();

  Future<Response> pushNotification(body) async {
    return await post(
      Uri.parse('https://fcm.googleapis.com/fcm/send'),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader:
            'key=AAAAwFGIay0:APA91bGAFQcKjrlh5KoBkNia_X9DDy7PQKjQWPI6Nl5bEm3I_-g_eU40QlPA3n4sXq1hsXWWRvBJM72HUAPiWNWYRPTKH1tL1RTdu3nN93tUocS8aTMGWfWg47J6y0RQCVlOKmtal1hw'
      },
      body: jsonEncode(body),
    );
  }

  Future<MResult<NotificationModel>> sendNotificationFollowEvent(
      MEvent event, MUser user) async {
    try {
      NotificationModel notification = NotificationModel(
        type: TypeNotify.followEvent,
        hostId: event.host?.id ?? "",
        data: MFollowEvent(event: event, user: user),
      );
      final result = await add(notification);
      if (result.isSuccess) {
        final body = {
          "to": event.host?.FCMToken ?? "",
          "notification": {
            "title": 'Your event has a new follower',
            "body": '${user.name} has been followed ${event.name}',
            'image': user.avatar ?? ""
          },
        };

        final res = await pushNotification(body);

        log('Response status: ${res.statusCode}');
        log('Response body: ${res.body}');
        return MResult.success(result.data);
      }
      return MResult.error('some error');
    } catch (e) {
      return MResult.exception(e);
    }
  }

  Future<MResult<NotificationModel>> sendNotificationFavoriteEvent(
      MEvent event, MUser user) async {
    try {
      NotificationModel notification = NotificationModel(
        type: TypeNotify.favoriteEvent,
        hostId: event.host?.id ?? "",
        data: MFollowEvent(event: event, user: user),
      );
      final result = await add(notification);
      if (result.isSuccess) {
        final body = {
          "to": event.host?.FCMToken ?? "",
          "notification": {
            "title": 'Your event has a new favorite person',
            "body": '${user.name} has been liked ${event.name}',
            'image': user.avatar ?? ""
          },
        };

        final res = await pushNotification(body);

        log('Response status: ${res.statusCode}');
        log('Response body: ${res.body}');
        return MResult.success(result.data);
      }
      return MResult.error('some error');
    } catch (e) {
      return MResult.exception(e);
    }
  }

  Future<MResult<NotificationModel>> sendNotificationFollowUser(
      MUser host, MUser follower) async {
    try {
      NotificationModel notification = NotificationModel(
        type: TypeNotify.followUser,
        hostId: host.id,
        data: MFollowUser(host: host, follower: follower),
      );

      final result = await add(notification);
      if (result.isSuccess) {
        final body = {
          "to": host.FCMToken ?? "",
          "notification": {
            "title": 'You have a new follower',
            "body": '${follower.name} has been followed you',
            'image': follower.avatar ?? ""
          },
        };
        final res = await pushNotification(body);

        log('Response status: ${res.statusCode}');
        log('Response body: ${res.body}');
        return MResult.success(result.data);
      }
      return MResult.error('some error');
    } catch (e) {
      return MResult.exception(e);
    }
  }

  Future<MResult<NotificationModel>> sendNotificationChangeEvent(
      MEvent event) async {
    try {
      List<Future<MResult<NotificationModel>>> listSnapshot = [];

      event.host?.followers?.forEach((element) {
        NotificationModel notification = NotificationModel(
          type: TypeNotify.changeEvent,
          hostId: element,
          data: MChangeEvent(event: event, host: event.host ?? MUser.empty()),
        );

        listSnapshot.add(add(notification));
      });
      final result = await Future.wait(listSnapshot);
      if (result.every((element) => element.isSuccess)) {
        final followers = await DomainManager()
            .user
            .getUsersByIds(event.host?.followers ?? []);
        if (followers.isSuccess) {
          List<Future<Response>> listNotification = followers.data!.map((e) {
            final body = {
              "to": e.FCMToken ?? "",
              "notification": {
                "title": 'The event you are following  ',
                "body": '${event.name} has  has changed',
                'image': event.images?[0] ?? ""
              },
            };
            return pushNotification(body);
          }).toList();

          await Future.wait(listNotification);

          return MResult.success(result[0].data);
        }
      }
      return MResult.error('some error');
    } catch (e) {
      return MResult.exception(e);
    }
  }

  Future<MResult<NotificationModel>> sendNotificationNewEvent(
      MEvent event) async {
    try {
      List<Future<MResult<NotificationModel>>> listSnapshot = [];

      event.host?.followers?.forEach((element) {
        NotificationModel notification = NotificationModel(
          type: TypeNotify.newEvent,
          hostId: element,
          data: MChangeEvent(event: event, host: event.host ?? MUser.empty()),
        );

        listSnapshot.add(add(notification));
      });
      final result = await Future.wait(listSnapshot);
      if (result.every((element) => element.isSuccess)) {
        final followers = await DomainManager()
            .user
            .getUsersByIds(event.host?.followers ?? []);
        if (followers.isSuccess) {
          List<Future<Response>> listNotification = followers.data!.map((e) {
            final body = {
              "to": e.FCMToken ?? "",
              "notification": {
                "title": '${event.host?.name ?? ""} added a new event',
                "body":
                    "${event.name} will take place on ${DateHelper.getFullDateTime(event.startDate)}",
                'image': event.images?[0] ?? ""
              },
            };
            return pushNotification(body);
          }).toList();

          await Future.wait(listNotification);

          return MResult.success(result[0].data);
        }
      }
      return MResult.error('some error');
    } catch (e) {
      return MResult.exception(e);
    }
  }

  Future<MResult<List<NotificationModel>>> getNotification(String hostId,
      [NotificationModel? lastNotification]) async {
    try {
      final QuerySnapshot<NotificationModel> querySnapshot;
      if (lastNotification != null) {
        querySnapshot = await ref
            .where('hostId', isEqualTo: hostId)
            .orderBy('dateTime', descending: true)
            .orderBy('type')
            .startAfter([
              lastNotification.dateTime?.toIso8601String(),
              lastNotification.type.name
            ])
            .limit(MPagination.defaultPageLimit)
            .get()
            .timeout(const Duration(seconds: 10));
      } else {
        querySnapshot = await ref
            .where('hostId', isEqualTo: hostId)
            .orderBy('dateTime', descending: true)
            .orderBy('type')
            .limit(MPagination.defaultPageLimit)
            .get()
            .timeout(const Duration(seconds: 10));
      }
      final docs = querySnapshot.docs.map((e) => e.data()).toList();

      return MResult.success(docs);
    } catch (e) {
      return MResult.exception(e);
    }
  }

  Future<MResult<int>> getCountNotification(
    String hostId,
  ) async {
    try {
      final AggregateQuerySnapshot querySnapshot = await ref
          .where('hostId', isEqualTo: hostId)
          .orderBy('dateTime', descending: true)
          .orderBy('type')
          .count()
          .get()
          .timeout(const Duration(seconds: 10));
      final result = querySnapshot.count;

      return MResult.success(result);
    } catch (e) {
      return MResult.exception(e);
    }
  }

  Future<MResult<int>> getCountNotificationNotSeen(
    String hostId,
  ) async {
    try {
      final AggregateQuerySnapshot querySnapshot = await ref
          .where('hostId', isEqualTo: hostId)
          .where('isSeen', isEqualTo: false)
          .orderBy('dateTime', descending: true)
          .orderBy('type')
          .count()
          .get()
          .timeout(const Duration(seconds: 10));
      final result = querySnapshot.count;

      return MResult.success(result);
    } catch (e) {
      return MResult.exception(e);
    }
  }
}
