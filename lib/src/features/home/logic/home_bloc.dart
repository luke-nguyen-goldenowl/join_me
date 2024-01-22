// ignore_for_file: curly_braces_in_flow_control_structures

import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:myapp/src/features/account/logic/account_bloc.dart';
import 'package:myapp/src/features/home/logic/home_state.dart';
import 'package:myapp/src/router/extras/story_view_extra.dart';
import 'package:myapp/src/network/domain_manager.dart';
import 'package:myapp/src/network/model/event/event.dart';
import 'package:myapp/src/network/model/story/story.dart';
import 'package:myapp/src/network/model/user/user.dart';
import 'package:myapp/src/network/model/user_story/user_story.dart';
import 'package:myapp/src/router/coordinator.dart';
import 'package:myapp/src/utils/utils.dart';

class HomeBloc extends Cubit<HomeState> {
  HomeBloc() : super(HomeState.ds()) {
    getDateHome();
  }
  DomainManager domain = DomainManager();

  void getDateHome() async {
    if (!isClosed) emit(state.copyWith(isLoading: true));
    final MUser user = GetIt.I<AccountBloc>().state.user;
    await Future.wait([
      getUsersEvents(user),
      getPopular(user),
      getUpcoming(user),
      getFollowed(user),
      getPeople(user),
    ]);

    if (!isClosed) emit(state.copyWith(isLoading: false));
  }

  void clearDateHome() {
    emit(HomeState.ds());
  }

  Future<void> getUsersEvents(MUser user) async {
    try {
      final result = await domain.userEvent
          .getUserStoryByIds([user.id, ...user.followed ?? []]);
      if (result.isSuccess) {
        emit(state.copyWith(userStory: result.data));
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> getPopular(MUser user) async {
    try {
      final result = await domain.event.getEventsPopular(user.id);
      if (result.isSuccess) {
        emit(state.copyWith(popular: result.data));
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> getUpcoming(MUser user) async {
    try {
      final result = await domain.event.getEventsUpcoming(user.id);
      if (result.isSuccess) {
        emit(state.copyWith(upcoming: result.data));
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> getPeople(MUser user) async {
    try {
      if (user.followers != null && user.followed!.isEmpty) {
        return emit(state.copyWith(people: []));
      }
      final result = await domain.event.getEventsPeople(user.followed ?? []);
      if (result.isSuccess) {
        emit(state.copyWith(people: result.data));
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> getFollowed(MUser user) async {
    try {
      final result = await domain.event.getEventsFollow(user.id);
      if (result.isSuccess) {
        emit(state.copyWith(followed: result.data));
      }
    } catch (e) {
      print(e);
    }
  }

  List<MEvent> getListEvents(TypeListEventHome type) {
    switch (type) {
      case TypeListEventHome.followed:
        return state.followed;
      case TypeListEventHome.popular:
        return state.popular;
      case TypeListEventHome.upcoming:
        return state.upcoming;
      case TypeListEventHome.people:
        return state.people;
      default:
        return state.popular;
    }
  }

  void goStoryView(String hostId) async {
    AppCoordinator.showStoryScreen(
        extra: StoryViewExtra(
            id: hostId,
            userStory: [...state.userStory],
            handleSeenStory: handleSeenStory));
  }

  void goDetailEvent(int indexEvent, MEvent event) async {
    try {
      final eventFromDetailEvent =
          await AppCoordinator.showEventDetails(id: event.id ?? "") as MEvent?;
      if (event.followersId?.length !=
          eventFromDetailEvent?.followersId?.length) {
        final newListFollowed = [...state.followed];

        if (event.followersId != null &&
            eventFromDetailEvent?.followersId != null) {
          if (event.followersId!.length >
              eventFromDetailEvent!.followersId!.length) {
            newListFollowed.removeWhere((element) => element.id == event.id);
          } else {
            newListFollowed.add(eventFromDetailEvent);
          }
        }
        emit(state.copyWith(followed: newListFollowed));
      }
    } catch (e) {
      log(e.toString());
    }
  }

  void handleSeenStory(int indexUser, int indexStory) {
    try {
      final MUser user = GetIt.I<AccountBloc>().state.user;
      if (state.userStory[indexUser].stories[indexStory].viewers
              ?.contains(user.id) ??
          false) {
        return;
      }
      final List<String> newViewer = [
        ...state.userStory[indexUser].stories[indexStory].viewers ?? [],
        user.id
      ];

      final MStory newStory = state.userStory[indexUser].stories[indexStory]
          .copyWith(viewers: newViewer);

      final List<MStory> newListStory = [...state.userStory[indexUser].stories];
      newListStory[indexStory] = newStory;

      final List<MUserStory> newUserStory = [...state.userStory];
      newUserStory[indexUser] =
          newUserStory[indexUser].copyWith(stories: newListStory);

      emit(state.copyWith(userStory: newUserStory));
    } catch (e) {
      print(e);
    }
  }

  void goAddStoryScreen() async {
    final MStory? story = await AppCoordinator.showAddStoryScreen();
    if (story != null) {
      final MUser user = GetIt.I<AccountBloc>().state.user;
      List<MUserStory> newUserStory = [...state.userStory];
      if (!isNullOrEmpty(state.userStory) &&
          state.userStory[0].user.id == user.id) {
        final newStoriesOfUser = [...state.userStory[0].stories, story];
        final MUserStory newMUserStory =
            MUserStory(user: user, stories: newStoriesOfUser);

        newUserStory[0] = newMUserStory;
      } else {
        final MUserStory newMUserStory =
            MUserStory(user: user, stories: [story]);

        newUserStory.insert(0, newMUserStory);
      }

      if (!isClosed) emit(state.copyWith(userStory: newUserStory));
    }
  }
}
