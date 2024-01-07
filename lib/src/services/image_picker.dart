import 'package:image_picker/image_picker.dart';
import 'package:myapp/src/dialogs/alert_wrapper.dart';
import 'package:myapp/src/dialogs/widget/alert_dialog.dart';
import 'package:myapp/src/localization/localization_utils.dart';

class XImagePicker {
  Future<XFile?> onPickImage() async {
    final ImagePicker _picker = ImagePicker();
    final result = await XAlert.show(
      body: S.text.camera_choose_option_take_image,
      actions: [
        XAlertButton<ImageSource>(
          key: ImageSource.gallery,
          title: S.text.camera_image_from_gallery,
        ),
        XAlertButton<ImageSource>(
          key: ImageSource.camera,
          title: S.text.camera_image_from_camera,
        ),
      ],
    );
    if (result != null) {
      final XFile? photo = await _picker.pickImage(source: ImageSource.gallery);
      return photo;
    }
    return null;
  }

  Future<List<XFile>> onPickMultiImage({int limit = 6}) async {
    final ImagePicker _picker = ImagePicker();
    final List<XFile> photo = await _picker.pickMultiImage();
    return photo.take(limit).toList();
  }
}
