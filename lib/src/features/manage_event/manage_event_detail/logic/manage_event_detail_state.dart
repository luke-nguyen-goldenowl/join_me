// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';

import 'package:myapp/src/network/model/event/event.dart';
import 'package:myapp/src/network/model/user/user.dart';

class ManageEventDetailState {
  int indexPageImage;
  MEvent event;
  List<MUser> followers;

  ManageEventDetailState({
    required this.indexPageImage,
    required this.event,
    required this.followers,
  });

  factory ManageEventDetailState.ds() {
    return ManageEventDetailState(
        event: MEvent(), indexPageImage: 0, followers: []);
  }

  ManageEventDetailState copyWith({
    int? indexPageImage,
    MEvent? event,
    List<MUser>? followers,
  }) {
    return ManageEventDetailState(
      indexPageImage: indexPageImage ?? this.indexPageImage,
      event: event ?? this.event,
      followers: followers ?? this.followers,
    );
  }

  @override
  bool operator ==(covariant ManageEventDetailState other) {
    if (identical(this, other)) return true;

    return other.indexPageImage == indexPageImage &&
        other.event == event &&
        listEquals(other.followers, followers);
  }

  @override
  int get hashCode =>
      indexPageImage.hashCode ^ event.hashCode ^ followers.hashCode;
}
