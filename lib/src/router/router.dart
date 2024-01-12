import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:myapp/src/_dev/dev_screen.dart';
import 'package:myapp/src/features/account/profile/view/edit_profile_view.dart';
import 'package:myapp/src/features/add_event/view/add_event_view.dart';
import 'package:myapp/src/features/dashboard/logic/navigation_bar_item.dart';
import 'package:myapp/src/features/account/profile/view/profile_view.dart';
import 'package:myapp/src/features/account/view/account_view.dart';
import 'package:myapp/src/features/authentication/view/forgot_view.dart';
import 'package:myapp/src/features/authentication/view/signin_view.dart';
import 'package:myapp/src/features/authentication/view/signup_view.dart';
import 'package:myapp/src/features/dashboard/view/dashboard_view.dart';
import 'package:myapp/src/features/detail_event/view/detail_event_view.dart';
import 'package:myapp/src/features/event/view/event_view.dart';
import 'package:myapp/src/features/followed/past/view/past_event_followed_view.dart';
import 'package:myapp/src/features/followed/upcoming/view/upcoming_event_followed_view.dart';
import 'package:myapp/src/features/followed/view/followed_view.dart';
import 'package:myapp/src/features/home/view/home_view.dart';
import 'package:myapp/src/features/manage_event/edit_event/view/edit_event_view.dart';
import 'package:myapp/src/features/manage_event/manage_event_detail/view/manage_event_detail_view.dart';
import 'package:myapp/src/features/manage_event/view/manage_event_view.dart';
import 'package:myapp/src/features/notification/view/notification_view.dart';
import 'package:myapp/src/features/profile_other_user/view/profile_other_user_view.dart';
import 'package:myapp/src/features/sample/view/sample_detail_view.dart';
import 'package:myapp/src/features/sample/view/sample_list_view.dart';
import 'package:myapp/src/features/search/view/search_view.dart';
import 'package:myapp/src/features/home/story/view/add_story_view.dart';
import 'package:myapp/src/features/home/story/view/story_view.dart';
import 'package:myapp/src/network/model/user_story/user_story.dart';
import '../features/common/view/not_found_view.dart';
import 'coordinator.dart';
import 'route_name.dart';

class AppRouter {
  late final router = GoRouter(
    navigatorKey: AppCoordinator.navigatorKey,
    initialLocation: AppRouteNames.signIn.path,
    debugLogDiagnostics: kDebugMode,
    observers: [BotToastNavigatorObserver()],
    routes: <RouteBase>[
      GoRoute(
        parentNavigatorKey: AppCoordinator.navigatorKey,
        path: AppRouteNames.signIn.path,
        name: AppRouteNames.signIn.name,
        builder: (_, __) => const SigninView(),
        routes: <RouteBase>[
          GoRoute(
            parentNavigatorKey: AppCoordinator.navigatorKey,
            path: AppRouteNames.signUp.subPath,
            name: AppRouteNames.signUp.name,
            builder: (_, __) => const SignupView(),
          ),
          GoRoute(
            parentNavigatorKey: AppCoordinator.navigatorKey,
            path: AppRouteNames.forgotPassword.subPath,
            name: AppRouteNames.forgotPassword.name,
            builder: (_, __) => const ForgotPasswordView(),
          ),
        ],
      ),
      ShellRoute(
        navigatorKey: AppCoordinator.shellKey,
        builder: (context, state, child) => DashBoardScreen(
          currentItem: XNavigationBarItems.fromLocation(state.uri.toString()),
          body: child,
        ),
        routes: <RouteBase>[
          GoRoute(
            path: AppRouteNames.home.path,
            name: AppRouteNames.home.name,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: HomeView(),
            ),
            routes: <RouteBase>[
              GoRoute(
                parentNavigatorKey: AppCoordinator.navigatorKey,
                path: AppRouteNames.sample.subPath,
                name: AppRouteNames.sample.name,
                builder: (_, __) => const SampleItemListView(),
                routes: <RouteBase>[
                  GoRoute(
                    parentNavigatorKey: AppCoordinator.navigatorKey,
                    path: AppRouteNames.sampleDetails.buildSubPathParam,
                    name: AppRouteNames.sampleDetails.name,
                    builder: (_, state) {
                      final id = state.pathParameters[
                          AppRouteNames.sampleDetails.paramName]!;
                      return SampleItemDetailsView(id: id);
                    },
                  )
                ],
              ),

              // _detailEventRoute,
              GoRoute(
                parentNavigatorKey: AppCoordinator.navigatorKey,
                path: AppRouteNames.story.buildSubPathParam,
                name: AppRouteNames.story.name,
                builder: (_, state) {
                  final id =
                      state.pathParameters[AppRouteNames.story.paramName]!;
                  final extra = state.extra! as List<dynamic>;
                  final userStory = extra[0] as List<MUserStory>;
                  final handleSeenStory = extra[1] as Function(int, int);
                  return StoryView(
                    id: id,
                    userStory: userStory,
                    handleSeenStory: handleSeenStory,
                  );
                },
              ),
              GoRoute(
                parentNavigatorKey: AppCoordinator.navigatorKey,
                path: AppRouteNames.addStory.subPath,
                name: AppRouteNames.addStory.name,
                builder: (_, __) => const AddStoryView(),
              )
            ],
          ),
          GoRoute(
            path: AppRouteNames.event.path,
            name: AppRouteNames.event.name,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: EventHomeView(),
            ),
          ),
          GoRoute(
            path: AppRouteNames.followed.path,
            name: AppRouteNames.followed.name,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: FollowedHomeView(),
            ),
            routes: <RouteBase>[
              GoRoute(
                path: AppRouteNames.pastFollowed.subPath,
                name: AppRouteNames.pastFollowed.name,
                builder: (_, __) => const PastEventFollowedView(),
              ),
              GoRoute(
                path: AppRouteNames.upcomingFollowed.subPath,
                name: AppRouteNames.upcomingFollowed.name,
                builder: (_, __) => const UpcomingEventFollowedView(),
              ),
            ],
          ),
          GoRoute(
            path: AppRouteNames.manageEvent.path,
            name: AppRouteNames.manageEvent.name,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: ManageEventView(),
            ),
            routes: <RouteBase>[
              GoRoute(
                parentNavigatorKey: AppCoordinator.navigatorKey,
                path: AppRouteNames.manageEventDetail.buildSubPathParam,
                name: AppRouteNames.manageEventDetail.name,
                builder: (_, state) {
                  final id = state.pathParameters[
                      AppRouteNames.manageEventDetail.paramName]!;
                  return ManageEventDetailView(
                    id: id,
                  );
                },
              ),
              GoRoute(
                parentNavigatorKey: AppCoordinator.navigatorKey,
                path: AppRouteNames.editEvent.buildSubPathParam,
                name: AppRouteNames.editEvent.name,
                builder: (_, state) {
                  final id =
                      state.pathParameters[AppRouteNames.editEvent.paramName]!;
                  return EditEvent(
                    id: id,
                  );
                },
              ),
            ],
          ),
          GoRoute(
            path: AppRouteNames.dev.path,
            name: AppRouteNames.dev.name,
            builder: (_, __) => const DevScreen(),
          ),
        ],
      ),
      GoRoute(
        parentNavigatorKey: AppCoordinator.navigatorKey,
        path: AppRouteNames.account.path,
        name: AppRouteNames.account.name,
        builder: (_, __) => const AccountHomeView(),
        routes: <RouteBase>[
          GoRoute(
            parentNavigatorKey: AppCoordinator.navigatorKey,
            path: AppRouteNames.profile.subPath,
            name: AppRouteNames.profile.name,
            builder: (_, __) => const ProfileView(),
            routes: <RouteBase>[
              GoRoute(
                parentNavigatorKey: AppCoordinator.navigatorKey,
                path: AppRouteNames.editProfile.subPath,
                name: AppRouteNames.editProfile.name,
                builder: (_, __) => const EditProfileView(),
              )
            ],
          )
        ],
      ),
      GoRoute(
        parentNavigatorKey: AppCoordinator.navigatorKey,
        path: AppRouteNames.addEvent.path,
        name: AppRouteNames.addEvent.name,
        builder: (_, __) => const AddEventView(),
      ),
      GoRoute(
        parentNavigatorKey: AppCoordinator.navigatorKey,
        path: AppRouteNames.notify.path,
        name: AppRouteNames.notify.name,
        builder: (_, __) => const NotificationView(),
      ),
      GoRoute(
        parentNavigatorKey: AppCoordinator.navigatorKey,
        path: AppRouteNames.search.path,
        name: AppRouteNames.search.name,
        builder: (_, __) => const SearchView(),
      ),
      GoRoute(
        parentNavigatorKey: AppCoordinator.navigatorKey,
        path: AppRouteNames.profileOtherUser.buildPathParam,
        name: AppRouteNames.profileOtherUser.name,
        builder: (_, state) {
          final id =
              state.pathParameters[AppRouteNames.profileOtherUser.paramName]!;
          return ProfileOtherUserView(id: id);
        },
      ),
      GoRoute(
        parentNavigatorKey: AppCoordinator.navigatorKey,
        path: AppRouteNames.detailEvent.buildPathParam,
        name: AppRouteNames.detailEvent.name,
        builder: (_, state) {
          final id = state.pathParameters[AppRouteNames.detailEvent.paramName]!;
          return DetailEventView(id: id);
        },
      )
    ],
    errorBuilder: (_, __) => const NotFoundView(),
  );
}
