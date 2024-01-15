import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:myapp/src/features/account/logic/account_bloc.dart';
import 'package:myapp/src/network/domain_manager.dart';
import 'package:myapp/src/network/model/user/user.dart';

class UserBloc extends Cubit<MUser> {
  UserBloc({required userId}) : super(MUser(id: userId)) {
    getUser(userId);
  }
  DomainManager domain = DomainManager();

  void getUser(String userId) async {
    final user = await domain.user.getUser(userId);
    if (user.isSuccess) {
      if (!isClosed) emit(user.data ?? state);
    }
  }

  void onPressedFollowHost() async {
    List<String> newFollower = [...state.followers!];
    final user = GetIt.I<AccountBloc>().state.user.copyWith();
    List<String> newFollowed = [...user.followed!];
    final bool isFollowed;
    if (newFollower.contains(user.id)) {
      newFollower.remove(user.id);
      newFollowed.remove(state.id);
      isFollowed = true;
    } else {
      newFollower.add(user.id);
      newFollowed.add(state.id);
      isFollowed = false;
    }

    final result =
        await domain.user.updateFollowers(state.id, user.id, isFollowed);
    if (result.isSuccess) {
      emit(state.copyWith(followers: newFollower));
      GetIt.I<AccountBloc>().emit(GetIt.I<AccountBloc>()
          .state
          .copyWith(user: user.copyWith(followed: newFollowed)));
    }
  }
}
