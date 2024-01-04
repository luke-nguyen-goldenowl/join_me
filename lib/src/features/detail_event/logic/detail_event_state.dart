// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:myapp/src/network/model/event/event.dart';

class DetailEventState {
  int indexPageImage;

  bool isLoading;
  MEvent? event;

  DetailEventState({
    this.indexPageImage = 0,
    this.event,
    this.isLoading = false,
  });

  DetailEventState copyWith({
    int? indexPageImage,
    MEvent? event,
    bool? isLoading,
  }) {
    return DetailEventState(
      indexPageImage: indexPageImage ?? this.indexPageImage,
      event: event ?? this.event,
      isLoading: isLoading ?? this.isLoading,
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

    return other.indexPageImage == indexPageImage &&
        other.isLoading == isLoading &&
        other.event == event;
  }

  @override
  int get hashCode =>
      indexPageImage.hashCode ^ isLoading.hashCode ^ event.hashCode;
}
