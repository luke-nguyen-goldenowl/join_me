import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:myapp/src/features/account/logic/account_bloc.dart';
import 'package:myapp/src/features/home/logic/home_state.dart';
import 'package:myapp/src/network/domain_manager.dart';
import 'package:myapp/src/network/model/event/event.dart';
import 'package:myapp/src/network/model/story/story.dart';
import 'package:myapp/src/network/model/user/user.dart';
import 'package:myapp/src/network/model/user_story/user_story.dart';

class HomeBloc extends Cubit<HomeState> {
  HomeBloc() : super(HomeState.ds()) {
    getDateHome();
  }
  DomainManager domain = DomainManager();

  void getDateHome() {
    final MUser user = GetIt.I<AccountBloc>().state.user;
    getUsersEvents(user);
    getPopular(user);
    getUpcoming(user);
    getFollowed(user);
    getPeople(user);
  }

  void clearDateHome() {
    emit(HomeState.ds());
  }

  void getUsersEvents(MUser user) async {
    try {
      final result =
          await domain.userEvent.getUserStoryByIds(user.followed ?? []);
      if (result.isSuccess) {
        emit(state.copyWith(userStory: result.data));
      }
    } catch (e) {
      print(e);
    }
  }

  void getPopular(MUser user) async {
    try {
      final result = await domain.event.getEventsPopular(user.id);
      if (result.isSuccess) {
        emit(state.copyWith(popular: result.data));
      }
    } catch (e) {
      print(e);
    }
  }

  void getUpcoming(MUser user) async {
    try {
      final result = await domain.event.getEventsUpcoming(user.id);
      if (result.isSuccess) {
        emit(state.copyWith(upcoming: result.data));
      }
    } catch (e) {
      print(e);
    }
  }

  void getPeople(MUser user) async {
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

  void getFollowed(MUser user) async {
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
}
