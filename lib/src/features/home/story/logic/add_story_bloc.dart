import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myapp/src/dialogs/alert_wrapper.dart';
import 'package:myapp/src/dialogs/toast_wrapper.dart';
import 'package:myapp/src/features/account/logic/account_bloc.dart';
import 'package:myapp/src/features/home/story/logic/add_story_state.dart';
import 'package:myapp/src/network/domain_manager.dart';
import 'package:myapp/src/network/model/event/event.dart';
import 'package:myapp/src/network/model/story/story.dart';
import 'package:myapp/src/router/coordinator.dart';

class AddStoryBloc extends Cubit<AddStoryState> {
  AddStoryBloc() : super(AddStoryState());
  DomainManager domain = DomainManager();

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

  void selectEvent(MEvent? event) {
    emit(state.copyWith(event: event));
  }

  Future<void> getEvents() async {
    try {
      if (state.events != null && state.events!.isNotEmpty) return;
      final events = await domain.event
          .getEventsByUser(GetIt.I<AccountBloc>().state.user.id);
      if (events.isSuccess) {
        if (!isClosed) emit(state.copyWith(events: events.data));
      } else {
        if (!isClosed) emit(state.copyWith(events: []));
      }
    } catch (e) {
      print(e);
    }
  }

  void onPressPost() async {
    try {
      if (!isClosed) emit(state.copyWith(isPosting: true));

      final MStory story = MStory(
        host: GetIt.I<AccountBloc>().state.user,
        event: state.event!,
        time: DateTime.now(),
        image: state.image!.path,
      );
      final result = await domain.story.addStory(story);
      if (!isClosed) emit(state.copyWith(isPosting: false));

      if (result.isSuccess) {
        AppCoordinator.pop();
        XToast.success('Create story success');
      } else {
        XAlert.show(title: 'Create story fail', body: result.error);
      }
    } catch (e) {
      if (!isClosed) emit(state.copyWith(isPosting: false));
      XAlert.show(title: 'Create story fail', body: e.toString());
      print(e);
    }
  }
}
