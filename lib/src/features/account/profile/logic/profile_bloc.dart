import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myapp/src/features/account/profile/logic/profile_state.dart';

class ProfileBloc extends Cubit<ProfileState> {
  ProfileBloc() : super(ProfileState());

  void setName(String name) {
    emit(state.copyWith(name: name));
  }

  void setCurrentPassword(String password) {
    emit(state.copyWith(currentPassword: password));
  }

  void setNewPassword(String password) {
    emit(state.copyWith(newPassword: password));
  }

  Future<XFile?> _pickImageToGallery(ImagePicker picker) async {
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    return image;
  }

  Future<XFile?> _pickImageToCamera(ImagePicker picker) async {
    final XFile? image = await picker.pickImage(source: ImageSource.camera);
    return image;
  }

  void pickImage(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image;
    switch (source) {
      case ImageSource.camera:
        image = await _pickImageToCamera(picker);
        break;
      case ImageSource.gallery:
        image = await _pickImageToGallery(picker);
        break;
      default:
        image = null;
        break;
    }
    emit(state.copyWith(avatar: image));
  }
}
