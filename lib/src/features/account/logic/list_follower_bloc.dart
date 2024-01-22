import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:myapp/src/features/account/logic/account_bloc.dart';
import 'package:myapp/src/features/account/logic/list_follower_state.dart';
import 'package:myapp/src/network/domain_manager.dart';

class ListFollowerBloc extends Cubit<ListFollowerState> {
  ListFollowerBloc() : super(ListFollowerState()) {
    getFollower();
  }
  DomainManager get domain => DomainManager();
  final user = GetIt.I<AccountBloc>().state.user;

  void getFollower() async {
    final result = await domain.user.getUsersByIds(user.followers ?? []);
    if (result.isSuccess) {
      if (!isClosed) emit(state.copyWith(followers: result.data));
    }
  }

  Future<void> refreshData() async {
    if (!isClosed) {
      emit(state.copyWith(followers: []));
    }
    getFollower();
  }
}
