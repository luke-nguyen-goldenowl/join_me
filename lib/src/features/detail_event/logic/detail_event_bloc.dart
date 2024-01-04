import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:myapp/src/features/account/logic/account_bloc.dart';
import 'package:myapp/src/features/detail_event/logic/detail_event_state.dart';
import 'package:flutter/material.dart';
import 'package:myapp/src/network/domain_manager.dart';
import 'package:myapp/src/network/model/event/event.dart';
import 'package:myapp/src/network/model/user/user.dart';

class DetailEventBloc extends Cubit<DetailEventState> {
  DetailEventBloc() : super(DetailEventState());
  PageController controller = PageController();

  DomainManager domain = DomainManager();

  void setIndexPageImage(int value) {
    emit(state.copyWith(indexPageImage: value));
  }

  void getEvent(String eventId) async {
    if (!isClosed) emit(state.copyWith(isLoading: true));
    try {
      final result = await domain.event.getEvent("uWbVA0CkBqVxhYZ5QHYT");
      if (result.isSuccess) {
        MEvent event = result.data!;
        emit(state.copyWith(event: event));
      }
    } catch (e) {
      print(e);
    }
    if (!isClosed) emit(state.copyWith(isLoading: true));
  }

  void onPressedFollowHost() async {
    try {
      List<String> newFollower = [...state.event!.host!.followers!];

      if (state.event!.host!.followers!
          .contains(GetIt.I<AccountBloc>().state.user.id)) {
        newFollower.remove(GetIt.I<AccountBloc>().state.user.id);
      } else {
        newFollower.add(GetIt.I<AccountBloc>().state.user.id);
      }
      final MUser newUser = state.event!.host!.copyWith(followers: newFollower);
      final result = await domain.user.updateFollowers(newUser);
      if (result.isSuccess) {
        final MEvent newEvent = state.event!.copyWith(host: newUser);
        emit(state.copyWith(event: newEvent));
      }
    } catch (e) {
      print(e);
    }
  }
}
