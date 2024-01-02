// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:myapp/src/network/model/common/pagination/pagination.dart';
import 'package:myapp/src/network/model/event/event.dart';

class ProfileOtherUserState {
  MPagination<MEvent> paginationAttended;
  MPagination<MEvent> paginationEvents;
  MPagination<MEvent> paginationFavorites;

  ProfileOtherUserState({
    required this.paginationAttended,
    required this.paginationEvents,
    required this.paginationFavorites,
  });

  factory ProfileOtherUserState.ds() {
    return ProfileOtherUserState(
        paginationAttended: MPagination<MEvent>(),
        paginationEvents: MPagination<MEvent>(),
        paginationFavorites: MPagination<MEvent>());
  }

  ProfileOtherUserState copyWith({
    MPagination<MEvent>? paginationAttended,
    MPagination<MEvent>? paginationEvents,
    MPagination<MEvent>? paginationFavorites,
  }) {
    return ProfileOtherUserState(
      paginationAttended: paginationAttended ?? this.paginationAttended,
      paginationEvents: paginationEvents ?? this.paginationEvents,
      paginationFavorites: paginationFavorites ?? this.paginationFavorites,
    );
  }

  @override
  bool operator ==(covariant ProfileOtherUserState other) {
    if (identical(this, other)) return true;

    return other.paginationAttended == paginationAttended &&
        other.paginationEvents == paginationEvents &&
        other.paginationFavorites == paginationFavorites;
  }

  @override
  int get hashCode =>
      paginationAttended.hashCode ^
      paginationEvents.hashCode ^
      paginationFavorites.hashCode;
}
