import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:myapp/src/network/data/user/user_reference.dart';
import 'package:myapp/src/network/firebase/base_collection.dart';
import 'package:myapp/src/network/model/common/result.dart';
import 'package:myapp/src/network/model/event/event.dart';
import 'package:myapp/src/network/model/user/user.dart';

class EventReference extends BaseCollectionReference<MEvent> {
  EventReference()
      : super(
          FirebaseFirestore.instance.collection('events').withConverter<MEvent>(
                fromFirestore: (snapshot, options) => MEvent.fromMap(
                    snapshot.data() as Map<String, dynamic>, snapshot.id),
                toFirestore: (chatRoom, _) => chatRoom.toMap(),
              ),
          getObjectId: (e) => e.id!,
          setObjectId: (e, id) => e.copyWith(id: id),
        );

  Future<List<String>> _uploadImages(List<String> imagePaths) async {
    try {
      List<Future<String>> uploadTasks = [];

      // Tạo một thời gian đơn giản để tạo tên duy nhất cho mỗi ảnh

      for (String imagePath in imagePaths) {
        DateTime now = DateTime.now();

        String imageName = 'image_${now.microsecondsSinceEpoch}.jpg';

        // Tạo một tham chiếu đến ảnh trong Firebase Storage
        Reference ref = FirebaseStorage.instance.ref('events').child(imageName);

        // Tải ảnh lên Firebase Storage và lưu trữ Future của URL
        Future<String> uploadTask =
            ref.putFile(File(imagePath)).then((taskSnapshot) async {
          return await taskSnapshot.ref.getDownloadURL();
        });

        // Thêm Future của URL vào danh sách các tác vụ tải lên
        uploadTasks.add(uploadTask);
      }

      // Chờ tất cả các tác vụ tải lên hoàn thành và lấy danh sách URL
      List<String> downloadUrls = await Future.wait(uploadTasks);

      return downloadUrls;
    } catch (e) {
      print('Lỗi khi tải ảnh lên Firebase Storage: $e');
      return [];
    }
  }

  Future<MResult<MEvent>> addEvent(MEvent event) async {
    try {
      final listImage = await _uploadImages(event.images!);
      MEvent newEvent = event.copyWith(images: listImage);
      final MResult<MEvent> result = await add(newEvent);
      return MResult.success(result.data);
    } catch (e) {
      return MResult.exception(e);
    }
  }

  Future<MResult<MEvent>> getEvent(String eventId) async {
    try {
      UserReference userReference = UserReference();
      final MResult<MEvent> eventResult = await get(eventId);
      if (eventResult.isSuccess) {
        final MResult<MUser> user =
            await userReference.getUser(eventResult.data!.host!.id);
        if (user.isSuccess) {
          final MEvent event = eventResult.data!.copyWith(host: user.data);
          return MResult.success(event);
        } else {
          return MResult.error('host not found');
        }
      } else {
        return MResult.error('Event not found');
      }
    } catch (e) {
      return MResult.exception(e);
    }
  }

  Future<MResult> updateFollowEvent(
    String eventId,
    String userId,
    bool isFollowed,
  ) async {
    try {
      final result = await update(eventId, {
        'followersId': isFollowed
            ? FieldValue.arrayRemove([userId])
            : FieldValue.arrayUnion([userId])
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

  Future<MResult> updateFavoriteEvent(
    String eventId,
    String userId,
    bool isFavorite,
  ) async {
    try {
      final result = await update(eventId, {
        'favoritesId': isFavorite
            ? FieldValue.arrayRemove([userId])
            : FieldValue.arrayUnion([userId])
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

  Future<MResult<List<MEvent>>> getEventsByUser(String userId) async {
    try {
      DateTime currentDate = DateTime.now();

      final QuerySnapshot<MEvent> querySnapshot = await ref
          .where('host', isEqualTo: userId)
          .where('deadline', isGreaterThan: currentDate.toIso8601String())
          .orderBy('deadline')
          .get();
      final docs = querySnapshot.docs.map((e) => e.data()).toList();
      return MResult.success(docs);
    } catch (e) {
      return MResult.exception(e);
    }
  }
}
