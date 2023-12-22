import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:myapp/src/router/route_name.dart';
import 'package:myapp/src/router/router.dart';

class AppCoordinator {
  static AppRouter get rootRouter => GetIt.I<AppRouter>();
  static final navigatorKey = GlobalKey<NavigatorState>();
  static final shellKey = GlobalKey<NavigatorState>();
  static BuildContext get context => navigatorKey.currentState!.context;

  static void pop<T extends Object?>([T? result]) => context.pop(result);

  static void goNamed(
    String name, {
    Map<String, String> params = const <String, String>{},
    Map<String, dynamic> queryParams = const <String, dynamic>{},
    Object? extra,
  }) =>
      context.goNamed(
        name,
        pathParameters: params,
        queryParameters: queryParams,
        extra: extra,
      );

  static void showHomeScreen() => context.goNamed(AppRouteNames.home.name);
  static void showAccountScreen() =>
      context.pushNamed(AppRouteNames.account.name);
  static void showEventScreen() => context.goNamed(AppRouteNames.event.name);
  static void showFollowedScreen() =>
      context.goNamed(AppRouteNames.followed.name);
  static void showManageScreen() =>
      context.goNamed(AppRouteNames.manageEvent.name);
  // static Future<T?> showSignInScreen<T extends Object?>() =>
  //     context.pushNamed<T>(AppRouteNames.signIn.name);

  static void showSignInScreen<T extends Object?>() {
    while (context.canPop()) {
      context.pop();
    }
    context.pushReplacementNamed(AppRouteNames.signIn.name);
  }

  static Future<T?> showAddEventScreen<T extends Object?>() =>
      context.pushNamed<T>(AppRouteNames.addEvent.name);

  static Future<T?> showNotifyScreen<T extends Object?>() =>
      context.pushNamed<T>(AppRouteNames.notify.name);

  static Future<T?> showSearchScreen<T extends Object?>() =>
      context.pushNamed<T>(AppRouteNames.search.name);

  static Future<T?> showAddStoryScreen<T extends Object?>() =>
      context.pushNamed<T>(AppRouteNames.addStory.name);

  static Future<T?> showSignUpScreen<T extends Object?>() =>
      context.pushNamed<T>(AppRouteNames.signUp.name);

  static Future<T?> showForgotPasswordScreen<T extends Object?>() =>
      context.pushNamed<T>(AppRouteNames.forgotPassword.name);

  static Future<T?> showSampleScreen<T extends Object?>() =>
      context.pushNamed<T>(AppRouteNames.sample.name);

  static Future<T?> showSampleDetails<T extends Object?>(
          {required String id}) =>
      context.pushNamed<T>(
        AppRouteNames.sampleDetails.name,
        pathParameters: {AppRouteNames.sampleDetails.paramName!: id},
      );

  static Future<T?> showEventDetails<T extends Object?>({required String id}) =>
      context.pushNamed<T>(
        AppRouteNames.detailEvent.name,
        pathParameters: {AppRouteNames.detailEvent.paramName!: id},
      );

  static Future<T?> showStoryScreen<T extends Object?>({required String id}) =>
      context.pushNamed<T>(
        AppRouteNames.story.name,
        pathParameters: {AppRouteNames.story.paramName!: id},
      );
  static Future<T?> showProfileOtherUser<T extends Object?>(
          {required String id}) =>
      context.pushNamed<T>(
        AppRouteNames.profileOtherUser.name,
        pathParameters: {AppRouteNames.profileOtherUser.paramName!: id},
      );

  static Future<T?> showEditEventScreen<T extends Object?>(
          {required String id}) =>
      context.pushNamed<T>(
        AppRouteNames.editEvent.name,
        pathParameters: {AppRouteNames.editEvent.paramName!: id},
      );

  static Future<T?> showManageEventDetails<T extends Object?>(
          {required String id}) =>
      context.pushNamed<T>(
        AppRouteNames.manageEventDetail.name,
        pathParameters: {AppRouteNames.manageEventDetail.paramName!: id},
      );

  static Future<T?> showProfile<T extends Object?>() =>
      context.pushNamed<T>(AppRouteNames.profile.name);
}
