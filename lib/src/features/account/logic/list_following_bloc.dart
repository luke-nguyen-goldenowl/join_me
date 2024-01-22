import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:myapp/src/features/account/logic/account_bloc.dart';
import 'package:myapp/src/features/account/logic/list_following_state.dart';
import 'package:myapp/src/network/domain_manager.dart';

class ListFollowingBloc extends Cubit<ListFollowingState> {
  ListFollowingBloc() : super(ListFollowingState()) {
    getFollowing();
  }
  DomainManager get domain => DomainManager();
  final user = GetIt.I<AccountBloc>().state.user;

  void getFollowing() async {
    final result = await domain.user.getUsersByIds(user.followed ?? []);
    if (result.isSuccess) {
      if (!isClosed) emit(state.copyWith(followings: result.data));
    }
  }
}
