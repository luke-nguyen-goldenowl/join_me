import 'dart:convert';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get_it/get_it.dart';
import 'package:myapp/src/dialogs/alert_wrapper.dart';
import 'package:myapp/src/dialogs/toast_wrapper.dart';
import 'package:myapp/src/features/account/logic/account_bloc.dart';
import 'package:myapp/src/network/model/notification/notification_model.dart';
import 'package:myapp/src/router/coordinator.dart';
import 'package:myapp/src/services/user_prefs.dart';

import '../utils/utils.dart';

class XFirebaseMessage {
  factory XFirebaseMessage() => instance;
  XFirebaseMessage._internal();

  static final XFirebaseMessage instance = XFirebaseMessage._internal();
  static XFirebaseMessage get I => instance;

  static AndroidNotificationChannel channel = const AndroidNotificationChannel(
    'high_importance_channel',
    'High Importance Notifications',
    importance: Importance.high,
  );

  static final FlutterLocalNotificationsPlugin localNoti =
      FlutterLocalNotificationsPlugin();

  String? currentToken;
  late Stream<String> _tokenStream;

  late FirebaseMessaging messaging;

  bool isNotificationsInitialized = false;

  Future<void> initialize() async {
    messaging = FirebaseMessaging.instance;
    _tokenStream = messaging.onTokenRefresh;

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    await setupNotification();
    await configForegroundNotification();
    await registerTokenFCM();

    // NOTE: Request Permission doesn't necessarily implemented here.
    // You should follow the workflow of your project
    await requestPermission();
  }

  // NOTE: This function you must initialize Plugin Notification. For example:
  // - Awesome Notification:
  //  https://pub.dev/packages/awesome_notifications#-how-to-show-local-notifications
  // - Flutter Local Notification:
  //  https://firebase.flutter.dev/docs/messaging/notifications#foreground-notifications
  //
  //
  // NOTE: To set up for IOS, you can find the documentation
  // at https://firebase.flutter.dev/docs/messaging/apple-integration
  Future<void> setupNotification() async {
    if (isNotificationsInitialized) {
      return;
    }

    /// Update the iOS foreground notification presentation options to allow
    /// heads up notifications.
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true, // Required to display a heads up notification
      badge: true,
      sound: true,
    );

    configAndroid();

    // configForegroundNotification();
    configOnMessageOpenApp();
    isNotificationsInitialized = true;
  }

  static void configAndroid() async {
    await XFirebaseMessage.localNoti
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
    var initializationSettingsAndroid =
        const AndroidInitializationSettings('@mipmap/ic_launcher');

    var initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
    );
    XFirebaseMessage.localNoti.initialize(initializationSettings,
        onDidReceiveNotificationResponse: (response) async {
      print("onSelectNotification: ${response.payload ?? ''}");
      return handleFCM(json.decode(response.payload ?? '{}'));
    });
  }

  Future<void> requestPermission() async {
    try {
      NotificationSettings settings = await messaging.requestPermission(
        alert: true,
        announcement: true,
        badge: true,
        carPlay: true,
        criticalAlert: true,
        provisional: true,
        sound: true,
      );
      xLog.i('User granted permission: ${settings.authorizationStatus}');
    } catch (e) {
      xLog.e(e);
    }
  }

  Future<void> configForegroundNotification() async {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (message.notification != null) {
        AndroidNotification? android = message.notification?.android;
        if (android != null) showLocalNotification(message);
      }
    });
  }

  Future<void> configOnMessageOpenApp() async {
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      xLog.i("onMessageOpenedApp: ${json.encode(message.data)}");
      await handleFCM(message.data);
    });
  }

  @pragma('vm:entry-point')
  static Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    // If you're going to use other Firebase services in the background, such as Firestore,
    // make sure you call `initializeApp` before using other Firebase services.
    await Firebase.initializeApp();
    await XFirebaseMessage().setupNotification();
    await UserPrefs.I.initialize();

    // XFirebaseMessage().showLocalNotification(message);
  }

  Future<void> showLocalNotification(RemoteMessage message) async {
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;
    Map<String, dynamic>? data = message.data;

    if (notification != null && android != null) {
      var id = notification.hashCode;
      var title = notification.title;
      var body = notification.body;
      var payload = json.encode(data);
      var channelId = XFirebaseMessage.channel.id;
      var channelName = XFirebaseMessage.channel.name;
      var android = AndroidNotificationDetails(
        channelId,
        channelName,
        importance: Importance.max,
        priority: Priority.high,
        enableVibration: true,
        enableLights: true,
        icon: '@mipmap/launcher_icon',
        styleInformation: BigTextStyleInformation(
          body ?? '',
          summaryText: body,
          contentTitle: title,
          htmlFormatBigText: true,
          htmlFormatContent: true,
          htmlFormatTitle: true,
          htmlFormatContentTitle: true,
          htmlFormatSummaryText: true,
        ),
      );
      await XFirebaseMessage.localNoti.show(
        id,
        title,
        body,
        NotificationDetails(android: android),
        payload: payload,
      );
    }
  }

  Future<void> registerTokenFCM() async {
    // If you want to get a token from the web, you can find the documentation
    // at https://firebase.flutter.dev/docs/messaging/usage/#web-tokens
    await messaging.getToken().then((setToken)).onError((error, stackTrace) {
      xLog.e(error);
    });

    _tokenStream.listen(setToken);
  }

  Future<void> unregisterTokenFCM() async {
    await messaging.deleteToken().catchError((error) {
      xLog.e(error);
    });
    currentToken = null;
  }

  void setToken(String? token) {
    xLog.i('FCM Token: $token');
    if (token != null) {
      currentToken = token;
    }
  }

  Future<void> subscribeTopics(String topic) async {
    await messaging.subscribeToTopic(topic);
  }

  Future<void> unSubscribeTopics(String topic) async {
    await messaging.unsubscribeFromTopic(topic);
  }

  static Future<void> handleFCM(Map? message) async {
    var accState = GetIt.I<AccountBloc>().state;
    if (accState.isLogin) {
      XToast.showLoading();

      try {
        final noti =
            NotificationModel.fromMap(message as Map<String, dynamic>, "");

        switch (noti.type) {
          case TypeNotify.followEvent:
            AppCoordinator.showProfileOtherUser(id: noti.data.user.id);
            break;
          case TypeNotify.favoriteEvent:
            AppCoordinator.showProfileOtherUser(id: noti.data.user.id);
            break;
          case TypeNotify.followUser:
            AppCoordinator.showProfileOtherUser(id: noti.data.follower.id);
            break;
          case TypeNotify.newEvent:
            AppCoordinator.showEventDetails(id: noti.data.event.id);
            break;

          default:
            break;
        }
      } catch (e) {
        print(e);
      }

      XToast.hideLoading();
    } else {
      XAlert.show(body: "Log in to see more information");
    }
  }
}
