import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:myapp/src/features/account/logic/account_bloc.dart';
import 'package:myapp/src/features/detail_event/logic/detail_event_state.dart';
import 'package:flutter/material.dart';
import 'package:myapp/src/network/domain_manager.dart';
import 'package:myapp/src/network/model/event/event.dart';
import 'package:myapp/src/network/model/user/user.dart';

class DetailEventBloc extends Cubit<DetailEventState> {
  DetailEventBloc({required String eventId}) : super(DetailEventState()) {
    getEvent(eventId);
  }
  PageController controller = PageController();
  GoogleMapController? mapController;

  DomainManager domain = DomainManager();

  void onMapCreate(GoogleMapController controller) {
    mapController ??= controller;
  }

  void setIndexPageImage(int value) {
    emit(state.copyWith(indexPageImage: value));
  }

  void getEvent(String eventId) async {
    try {
      final result = await domain.event.getEvent(eventId);
      if (result.isSuccess) {
        MEvent event = result.data!;
        emit(state.copyWith(event: event));
      }
    } catch (e) {
      print(e);
    }
  }

  void onPressedFollowHost() async {
    try {
      List<String> newFollower = [...state.event?.host?.followers ?? []];
      final String userId = GetIt.I<AccountBloc>().state.user.id;
      final bool isFollowed;
      if (newFollower.contains(userId)) {
        newFollower.remove(userId);
        isFollowed = true;
      } else {
        newFollower.add(userId);
        isFollowed = false;
      }
      final MUser newUser =
          state.event?.host?.copyWith(followers: newFollower) ?? MUser.empty();
      final result =
          await domain.user.updateFollowers(newUser.id, userId, isFollowed);
      if (result.isSuccess) {
        final MEvent newEvent =
            state.event?.copyWith(host: newUser) ?? MEvent();
        emit(state.copyWith(event: newEvent));
      }
    } catch (e) {
      print(e);
    }
  }

  void onPressedFollowEvent() async {
    try {
      List<String> newFollower = [...state.event?.followersId ?? []];
      final String userId = GetIt.I<AccountBloc>().state.user.id;
      final bool isFollowed;
      if (newFollower.contains(userId)) {
        newFollower.remove(userId);
        isFollowed = true;
      } else {
        newFollower.add(userId);
        isFollowed = false;
      }

      final MEvent newEvent =
          state.event?.copyWith(followersId: newFollower) ?? MEvent();
      final result = await domain.event.updateFollowEvent(
        newEvent.id ?? "",
        userId,
        isFollowed,
      );
      if (result.isSuccess) {
        emit(state.copyWith(event: newEvent));
      }
    } catch (e) {
      print(e);
    }
  }

  void onPressedFavoriteEvent() async {
    try {
      List<String> newFavorites = [...state.event?.favoritesId ?? []];
      final String userId = GetIt.I<AccountBloc>().state.user.id;
      final bool isFavorite;
      if (newFavorites.contains(userId)) {
        newFavorites.remove(userId);
        isFavorite = true;
      } else {
        newFavorites.add(userId);
        isFavorite = false;
      }

      final MEvent newEvent =
          state.event?.copyWith(favoritesId: newFavorites) ?? MEvent();
      final result = await domain.event.updateFavoriteEvent(
        newEvent.id ?? "",
        userId,
        isFavorite,
      );
      if (result.isSuccess) {
        emit(state.copyWith(event: newEvent));
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Future<void> close() {
    mapController?.dispose();
    controller.dispose();
    return super.close();
  }
}
