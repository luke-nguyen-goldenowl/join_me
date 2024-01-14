import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myapp/src/network/firebase/base_collection.dart';
import 'package:myapp/src/network/model/common/result.dart';
import 'package:myapp/src/network/model/event/event.dart';
import 'package:myapp/src/network/model/notification/follow_event.dart';
import 'package:myapp/src/network/model/notification/follow_user.dart';
import 'package:myapp/src/network/model/notification/notification_model.dart';
import 'package:myapp/src/network/model/user/user.dart';
import 'package:myapp/src/services/firebase_message.dart';
import 'package:http/http.dart';
import 'dart:io';

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
        type: TypeNotify.favoriteEvent,
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
}
