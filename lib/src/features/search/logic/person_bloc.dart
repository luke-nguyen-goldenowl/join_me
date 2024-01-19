import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:myapp/src/features/account/logic/account_bloc.dart';
import 'package:myapp/src/features/search/logic/person_state.dart';
import 'package:myapp/src/network/domain_manager.dart';
import 'package:myapp/src/network/model/user/user.dart';

class PersonBloc extends Cubit<PersonState> {
  PersonBloc({required MUser person}) : super(PersonState(person: person));
  DomainManager domain = DomainManager();
  void onPressedFollowHost() async {
    try {
      List<String> newFollower = [...state.person.followers ?? []];
      final user = GetIt.I<AccountBloc>().state.user.copyWith();
      List<String> newFollowed = [...user.followed ?? []];
      final bool isFollowed;
      if (newFollower.contains(user.id)) {
        newFollower.remove(user.id);
        newFollowed.remove(state.person.id);
        isFollowed = true;
      } else {
        newFollower.add(user.id);
        newFollowed.add(state.person.id);
        isFollowed = false;
      }

      final result =
          await domain.user.updateFollowers(state.person, user, isFollowed);
      if (result.isSuccess) {
        final newUser = user.copyWith(followed: newFollowed);
        GetIt.I<AccountBloc>().onUserChange(AccountState(user: newUser));
        emit(state.copyWith(
            person: state.person.copyWith(followers: newFollower)));
      }
    } catch (e) {
      print(e);
    }
  }
}
