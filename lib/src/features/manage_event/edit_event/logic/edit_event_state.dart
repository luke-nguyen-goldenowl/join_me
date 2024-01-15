// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:myapp/src/network/model/event/event.dart';
import 'package:myapp/src/network/model/user/user.dart';

class EditEventState {
  MEvent event;
  int currentPage;
  TimeOfDay? time;
  bool isSaving;

  EditEventState({
    required this.event,
    required this.currentPage,
    this.time,
    required this.isSaving,
  });

  factory EditEventState.ds() {
    return EditEventState(
      currentPage: 0,
      event: MEvent(id: '1', host: MUser.empty()),
      time: null,
      isSaving: false,
    );
  }

  EditEventState copyWith({
    MEvent? event,
    int? currentPage,
    TimeOfDay? time,
    bool? isSaving,
  }) {
    return EditEventState(
      event: event ?? this.event,
      currentPage: currentPage ?? this.currentPage,
      time: time ?? this.time,
      isSaving: isSaving ?? this.isSaving,
    );
  }

  bool checkValidate() {
    if (currentPage == 0 && event.location == null) {
      return false;
    }
    if (currentPage == 1 &&
        (time == null ||
            event.deadline == null ||
            event.startDate == null ||
            event.type == null ||
            event.description == null ||
            (event.description?.isEmpty ?? true) ||
            event.name == null ||
            (event.name?.isEmpty ?? true) ||
            event.maxAttendee <= 0)) {
      return false;
    }

    return true;
  }

  @override
  bool operator ==(covariant EditEventState other) {
    if (identical(this, other)) return true;

    return other.event == event &&
        other.currentPage == currentPage &&
        other.time == time &&
        other.isSaving == isSaving;
  }

  @override
  int get hashCode {
    return event.hashCode ^
        currentPage.hashCode ^
        time.hashCode ^
        isSaving.hashCode;
  }
}
