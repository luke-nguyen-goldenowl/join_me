import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class XFirebaseStorage {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String> uploadImage(String imagePath, String folderName) async {
    try {
      DateTime now = DateTime.now();

      String imageName = 'image_${now.microsecondsSinceEpoch}.jpg';

      Reference ref = FirebaseStorage.instance.ref(folderName).child(imageName);

      String uploadTask =
          await ref.putFile(File(imagePath)).then((taskSnapshot) async {
        return taskSnapshot.ref.getDownloadURL();
      });

      return uploadTask;
    } catch (e) {
      print('Lỗi khi tải ảnh lên Firebase Storage: $e');
      return "";
    }
  }

  Future<List<String>> uploadImages(
      List<String> imagePaths, String folderName) async {
    try {
      List<Future<String>> uploadTasks = [];

      for (String imagePath in imagePaths) {
        DateTime now = DateTime.now();

        String imageName = 'image_${now.microsecondsSinceEpoch}.jpg';

        Reference ref = _storage.ref(folderName).child(imageName);

        Future<String> uploadTask =
            ref.putFile(File(imagePath)).then((taskSnapshot) async {
          return await taskSnapshot.ref.getDownloadURL();
        });

        uploadTasks.add(uploadTask);
      }

      List<String> downloadUrls = await Future.wait(uploadTasks);

      return downloadUrls;
    } catch (e) {
      print('Lỗi khi tải ảnh lên Firebase Storage: $e');
      return [];
    }
  }
}
