import 'package:image_picker/image_picker.dart';

class AddStoryState {
  XFile? image;
  String eventId;
  AddStoryState({this.eventId = "", this.image});

  AddStoryState copyWith({eventId, image}) {
    return AddStoryState(
      eventId: eventId ?? this.eventId,
      image: image ?? this.image,
    );
  }
}
