import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myapp/src/network/firebase/base_collection.dart';
import '../../model/common/result.dart';
import '../../model/user/user.dart';

class UserReference extends BaseCollectionReference<MUser> {
  UserReference()
      : super(
          FirebaseFirestore.instance.collection('users').withConverter<MUser>(
                fromFirestore: (snapshot, options) =>
                    MUser.fromJson(snapshot.data() as Map<String, dynamic>),
                toFirestore: (chatRoom, _) => chatRoom.toJson(),
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
      final resultFollower = await update(hostId, {
        'followers': isFollowed
            ? FieldValue.arrayRemove([followerId])
            : FieldValue.arrayUnion([followerId])
      });
      final resultFollowed = await update(followerId, {
        'followed': isFollowed
            ? FieldValue.arrayRemove([hostId])
            : FieldValue.arrayUnion([hostId])
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
      final result = await get(user.id);
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

  Future<MResult> updateUser(String userId,
      [String? imageUrl, String? name]) async {
    try {
      Map<String, dynamic> updateData = {};
      if (imageUrl != null) {
        updateData['avatar'] = imageUrl;
      }
      if (name != null) {
        updateData['name'] = name;
      }
      final result = await update(userId, updateData);
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
