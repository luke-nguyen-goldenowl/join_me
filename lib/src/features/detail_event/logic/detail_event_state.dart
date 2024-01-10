// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:myapp/src/network/model/event/event.dart';

class DetailEventState {
  int indexPageImage;

  MEvent? event;

  DetailEventState({
    this.indexPageImage = 0,
    this.event,
  });

  DetailEventState copyWith({
    int? indexPageImage,
    MEvent? event,
  }) {
    return DetailEventState(
      indexPageImage: indexPageImage ?? this.indexPageImage,
      event: event ?? this.event,
    );
  }

  bool isExpiredRegisterEvent() {
    if (event == null) return true;
    if (event!.deadline!.isBefore(DateTime.now()) ||
        event!.maxAttendee < event!.favoritesId!.length) return true;
    return false;
  }

  @override
  bool operator ==(covariant DetailEventState other) {
    if (identical(this, other)) return true;

    return other.indexPageImage == indexPageImage && other.event == event;
  }

  @override
  int get hashCode => indexPageImage.hashCode ^ event.hashCode;
}
