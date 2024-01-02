import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:myapp/src/features/profile_other_user/logic/profile_other_user_state.dart';
import 'package:myapp/src/network/domain_manager.dart';
import 'package:myapp/src/network/model/common/pagination/pagination.dart';
import 'package:myapp/src/network/model/event/event.dart';

class ProfileOtherUserBloc extends Cubit<ProfileOtherUserState> {
  ProfileOtherUserBloc() : super(ProfileOtherUserState.ds());

  DomainManager get domain => DomainManager();

  Future<void> loadMoreAttended() async {
    MPagination<MEvent> pagination = MPagination<MEvent>();

    await Future.delayed(const Duration(seconds: 2));

    pagination = pagination.addAll([
      ...state.paginationAttended.data,
      ...domain.event.getEventsByUser('1').data!
    ]);

    if (!isClosed) emit(state.copyWith(paginationAttended: pagination));
  }

  Future<void> loadMoreEvents() async {
    MPagination<MEvent> pagination = MPagination<MEvent>();

    await Future.delayed(const Duration(seconds: 2));

    pagination = pagination.addAll([
      ...state.paginationEvents.data,
      ...domain.event.getEventsByUser('1').data!
    ]);

    if (!isClosed) emit(state.copyWith(paginationEvents: pagination));
  }

  Future<void> loadMoreFavorites() async {
    MPagination<MEvent> pagination = MPagination<MEvent>();

    await Future.delayed(const Duration(seconds: 2));

    pagination = pagination.addAll([
      ...state.paginationFavorites.data,
      ...domain.event.getEventsByUser('1').data!
    ]);

    if (!isClosed) emit(state.copyWith(paginationFavorites: pagination));
  }
}
