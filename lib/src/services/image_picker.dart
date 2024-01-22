import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myapp/src/dialogs/alert_wrapper.dart';
import 'package:myapp/src/dialogs/widget/alert_dialog.dart';
import 'package:myapp/src/localization/localization_utils.dart';

class XImagePicker {
  Future<XFile?> onPickImage() async {
    final ImagePicker picker = ImagePicker();
    final result = await XAlert.show(
      body: S.text.camera_choose_option_take_image,
      actions: [
        XAlertButton(
          key: ImageSource.gallery.name,
          child: Row(
            children: [
              const Icon(Icons.image),
              const SizedBox(width: 20),
              Text(S.text.camera_image_from_gallery)
            ],
          ),
        ),
        XAlertButton(
          key: ImageSource.camera.name,
          child: Row(
            children: [
              const Icon(Icons.camera_alt),
              const SizedBox(width: 20),
              Text(S.text.camera_image_from_camera)
            ],
          ),
        ),
      ],
    );
    if (result != null) {
      if (result == "camera") {
        final XFile? photo = await picker.pickImage(source: ImageSource.camera);
        return photo;
      } else {
        final XFile? photo =
            await picker.pickImage(source: ImageSource.gallery);
        return photo;
      }
      // return photo;
    }
    return null;
  }

  Future<List<XFile>> onPickMultiImage({int limit = 6}) async {
    final ImagePicker picker = ImagePicker();
    final List<XFile> photo = await picker.pickMultiImage();
    return photo.take(limit).toList();
  }
}
