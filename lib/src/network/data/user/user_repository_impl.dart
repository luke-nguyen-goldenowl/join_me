// import 'package:firebase_auth/firebase_auth.dart';
import 'package:myapp/src/network/data/user/user_reference.dart';
import 'package:myapp/src/network/data/user/user_repository.dart';
import 'package:myapp/src/network/model/user/user.dart';

import '../../model/common/result.dart';

class UserRepositoryImpl extends UserRepository {
  final usersRef = UserReference();
  @override
  Future<MResult<MUser>> getUser(String id) async {
    try {
      final result = await usersRef.getUser(id);
      // final result = FirebaseAuth.instance.currentUser;
      if (result.isError) {
        return MResult.error('Not user login');
      }
      final user = MUser(
          id: result.data!.id,
          email: result.data!.email,
          name: result.data!.name,
          followers: result.data!.followers);
      return MResult.success(user);
    } catch (e) {
      return MResult.exception(e);
    }
  }

  @override
  Future<MResult<MUser>> getOrAddUser(MUser user) {
    return usersRef.getOrAddUser(user);
  }

  @override
  Future<MResult<List<MUser>>> getUsers() {
    return usersRef.getUsers();
  }
}
