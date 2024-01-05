// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';

import 'package:myapp/src/network/model/event/event.dart';
import 'package:myapp/src/network/model/user/user.dart';

class EditEventState {
  MEvent event;
  // LatLng? selectedLocation;
  int currentPage;
  // DateTime? startDate;
  // DateTime? deadlineDate;
  TimeOfDay? time;
  // String nameEvent;
  // String description;

  EditEventState({
    required this.event,
    required this.currentPage,
    this.time,
    // this.selectedLocation,
    // this.startDate,
    // this.deadlineDate,
    // required this.nameEvent,
    // required this.description,
  });

  factory EditEventState.ds() {
    return EditEventState(
      currentPage: 0,
      event: MEvent.ds(id: '1', host: MUser.empty()),
      time: null,
      // selectedLocation: null,
      // deadlineDate: null,
      // startDate: null,
      // description: "",
      // nameEvent: "",
    );
  }

  EditEventState copyWith({
    MEvent? event,
    LatLng? selectedLocation,
    int? currentPage,
    DateTime? startDate,
    DateTime? deadlineDate,
    TimeOfDay? time,
    String? nameEvent,
    String? description,
  }) {
    return EditEventState(
      event: event ?? this.event,
      currentPage: currentPage ?? this.currentPage,
      time: time ?? this.time,
      // selectedLocation: selectedLocation ?? this.selectedLocation,
      // startDate: startDate ?? this.startDate,
      // deadlineDate: deadlineDate ?? this.deadlineDate,
      // nameEvent: nameEvent ?? this.nameEvent,
      // description: description ?? this.description,
    );
  }

  @override
  bool operator ==(covariant EditEventState other) {
    if (identical(this, other)) return true;

    return other.event == event &&
        other.currentPage == currentPage &&
        other.time == time;
    // other.selectedLocation == selectedLocation &&
    // other.startDate == startDate &&
    // other.deadlineDate == deadlineDate &&
    // other.nameEvent == nameEvent &&
    // other.description == description;
  }

  @override
  int get hashCode {
    return event.hashCode ^ currentPage.hashCode ^ time.hashCode;
    // selectedLocation.hashCode ^
    // startDate.hashCode ^
    // deadlineDate.hashCode ^
    // nameEvent.hashCode ^
    // description.hashCode;
  }
}
