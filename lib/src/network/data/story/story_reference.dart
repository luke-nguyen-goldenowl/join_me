import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:myapp/src/network/firebase/base_collection.dart';
import 'package:myapp/src/network/model/common/result.dart';
import 'package:myapp/src/network/model/story/story.dart';

class StoryReference extends BaseCollectionReference<MStory> {
  StoryReference()
      : super(
          FirebaseFirestore.instance.collection('events').withConverter<MStory>(
                fromFirestore: (snapshot, options) => MStory.fromMap(
                    snapshot.data() as Map<String, dynamic>, snapshot.id),
                toFirestore: (chatRoom, _) => chatRoom.toMap(),
              ),
          getObjectId: (e) => e.id!,
          setObjectId: (e, id) => e.copyWith(id: id),
        );

  Future<String> _uploadImage(String imagePath) async {
    try {
      DateTime now = DateTime.now();

      String imageName = 'image_${now.microsecondsSinceEpoch}.jpg';

      Reference ref = FirebaseStorage.instance.ref('stories').child(imageName);

      Future<String> uploadTask =
          await ref.putFile(File(imagePath)).then((taskSnapshot) async {
        return taskSnapshot.ref.getDownloadURL();
      });

      return uploadTask;
    } catch (e) {
      print('Lỗi khi tải ảnh lên Firebase Storage: $e');
      return "";
    }
  }

  Future<MResult<MStory>> addStory(MStory story) async {
    try {
      final image = await _uploadImage(story.image);
      MStory newStory = story.copyWith(image: image);
      final MResult<MStory> result = await add(newStory);
      return MResult.success(result.data);
    } catch (e) {
      return MResult.exception(e);
    }
  }
}
