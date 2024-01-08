import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myapp/src/network/data/event/event_reference.dart';
import 'package:myapp/src/network/firebase/base_collection.dart';
import 'package:myapp/src/network/model/common/result.dart';
import 'package:myapp/src/network/model/event/event.dart';
import 'package:myapp/src/network/model/story/story.dart';
import 'package:myapp/src/services/firebase_storage.dart';

class StoryReference extends BaseCollectionReference<MStory> {
  StoryReference()
      : super(
          FirebaseFirestore.instance
              .collection('stories')
              .withConverter<MStory>(
                fromFirestore: (snapshot, options) => MStory.fromMap(
                    snapshot.data() as Map<String, dynamic>, snapshot.id),
                toFirestore: (chatRoom, _) => chatRoom.toMap(),
              ),
          getObjectId: (e) => e.id!,
          setObjectId: (e, id) => e.copyWith(id: id),
        );

  final XFirebaseStorage firebaseStorage = XFirebaseStorage();

  Future<MResult<MStory>> addStory(MStory story) async {
    try {
      final image = await firebaseStorage.uploadImage(story.image!, "stories");
      MStory newStory = story.copyWith(image: image);
      final MResult<MStory> result = await add(newStory);
      return MResult.success(result.data);
    } catch (e) {
      return MResult.exception(e);
    }
  }

  Future<MResult<List<MStory>>> getStoriesByUser(String userId) async {
    try {
      final EventReference eventReference = EventReference();
      DateTime now = DateTime.now();
      DateTime twentyFourHoursAgo = now.subtract(const Duration(hours: 24));
      final QuerySnapshot<MStory> querySnapshot = await ref
          .where('host', isEqualTo: userId)
          .where('time', isGreaterThan: twentyFourHoursAgo.toIso8601String())
          .orderBy('time')
          .get()
          .timeout(const Duration(seconds: 10));

      final docs = querySnapshot.docs.map((e) => e.data()).toList();
      List<Future<MResult<MEvent>>> futures = docs.map((story) {
        return eventReference.getEventNoUser(story.event?.id ?? "");
      }).toList();
      List<MResult<MEvent>> listEvent = await Future.wait(futures);
      List<MStory> result = docs
          .asMap()
          .map((key, value) {
            return MapEntry(key, value.copyWith(event: listEvent[key].data));
          })
          .values
          .toList();
      return MResult.success(result);
    } catch (e) {
      return MResult.exception(e);
    }
  }

  Future<MResult> updateViewerStory(String storyId, String userId) async {
    try {
      final result = await update(storyId, {
        'viewers': FieldValue.arrayUnion([userId])
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
}
