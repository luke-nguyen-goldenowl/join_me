import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myapp/src/network/firebase/base_collection.dart';
import '../../model/common/result.dart';
import '../../model/user/user.dart';

class UserReference extends BaseCollectionReference<MUser> {
  UserReference()
      : super(
          FirebaseFirestore.instance.collection('users').withConverter<MUser>(
                fromFirestore: (snapshot, options) =>
                    MUser.fromMap(snapshot.data() as Map<String, dynamic>),
                toFirestore: (chatRoom, _) => chatRoom.toMap(),
              ),
          getObjectId: (e) => e.id,
          setObjectId: (e, id) => e.copyWith(id: id),
        );

  Future<MResult<MUser>> getUser(String userId) async {
    try {
      final result = await get(userId);
      if (result.isError == false) {
        return result;
      } else {
        return MResult.success(result.data);
      }
    } catch (e) {
      return MResult.exception(e);
    }
  }

  Future<MResult> updateFollowers(
    String hostId,
    String followerId,
    bool isFollowed,
  ) async {
    try {
      final result = await update(hostId, {
        'followers': isFollowed
            ? FieldValue.arrayRemove([followerId])
            : FieldValue.arrayUnion([followerId])
      });
      if (result.isError == false) {
        return result;
      } else {
        return MResult.success(result.data);
      }
    } catch (e) {
      return MResult.exception(e);
    }
  }

  Future<MResult<MUser>> getOrAddUser(MUser user) async {
    try {
      final MResult<MUser> result = await get(user.id);
      if (result.isError == false) {
        return result;
      } else {
        final MResult<MUser> result = await set(user);
        return MResult.success(result.data);
      }
    } catch (e) {
      return MResult.exception(e);
    }
  }

  Future<MResult<List<MUser>>> getUsers() async {
    try {
      final QuerySnapshot<MUser> query =
          await ref.get().timeout(const Duration(seconds: 10));
      final docs = query.docs.map((e) => e.data()).toList();
      return MResult.success(docs);
    } catch (e) {
      return MResult.exception(e);
    }
  }

  Future<MResult<List<MUser>>> getUsersByIds(List<String> userIds) async {
    try {
      final result = await getDataByIds(userIds);
      if (result.isError == false) {
        return result;
      } else {
        return MResult.success(result.data);
      }
    } catch (e) {
      return MResult.exception(e);
    }
  }
}
