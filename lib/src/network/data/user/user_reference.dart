import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myapp/src/network/firebase/base_collection.dart';
import 'package:myapp/src/services/firebase_message.dart';
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
    MUser host,
    MUser follower,
    bool isFollowed,
  ) async {
    try {
      final resultFollower = await update(host.id, {
        'followers': isFollowed
            ? FieldValue.arrayRemove([follower.id])
            : FieldValue.arrayUnion([follower.id])
      });
      final resultFollowed = await update(follower.id, {
        'followed': isFollowed
            ? FieldValue.arrayRemove([host.id])
            : FieldValue.arrayUnion([host.id])
      });
      if (!resultFollower.isError && !resultFollowed.isError) {
        return resultFollower;
      } else {
        return MResult.success(resultFollower.data);
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

  Future<MResult<List<MUser>>> getUsersBySearch(String search, String userId,
      [MUser? lastUser]) async {
    try {
      final QuerySnapshot<MUser> querySnapshot = await ref
          .where('id', isNotEqualTo: userId)
          .where('caseSearchName', arrayContains: search)
          .get()
          .timeout(const Duration(seconds: 10));
      final docs = querySnapshot.docs.map((e) => e.data()).toList();
      return MResult.success(docs);
    } catch (e) {
      return MResult.exception(e);
    }
  }

  Future<MResult<int>> getCountUsersBySearch(
    String search,
    String userId,
  ) async {
    try {
      final AggregateQuerySnapshot querySnapshot = await ref
          .where('id', isNotEqualTo: userId)
          .where('caseSearchName', arrayContains: search)
          .count()
          .get()
          .timeout(const Duration(seconds: 10));
      final result = querySnapshot.count;
      return MResult.success(result);
    } catch (e) {
      return MResult.exception(e);
    }
  }

  Future<MResult> updateFCMTokenUser(
    String userId,
  ) async {
    try {
      final result = await update(
          userId, {'FCMToken': XFirebaseMessage.instance.currentToken});
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
