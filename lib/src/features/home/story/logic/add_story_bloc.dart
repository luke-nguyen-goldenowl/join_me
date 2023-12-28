import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myapp/src/features/home/story/logic/add_story_state.dart';

class AddStoryBloc extends Cubit<AddStoryState> {
  AddStoryBloc() : super(AddStoryState());

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
    emit(state.copyWith(image: image));
  }

  void selectEvent(String eventId) {
    emit(state.copyWith(eventId: eventId));
  }
}
