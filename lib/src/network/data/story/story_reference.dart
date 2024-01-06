import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myapp/src/network/firebase/base_collection.dart';
import 'package:myapp/src/network/model/common/result.dart';
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
}
