// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';

import 'package:myapp/src/network/model/event/event.dart';
import 'package:myapp/src/network/model/user/user.dart';

class EditEventState {
  MEvent event;
  LatLng? selectedLocation;
  int currentPage;
  DateTime? startDate;
  DateTime? deadlineDate;
  TimeOfDay? time;
  String nameEvent;
  String description;

  EditEventState({
    required this.event,
    this.selectedLocation,
    required this.currentPage,
    this.startDate,
    this.deadlineDate,
    this.time,
    required this.nameEvent,
    required this.description,
  });

  factory EditEventState.ds() {
    return EditEventState(
      currentPage: 0,
      event: MEvent.ds(id: '1', host: MUser.empty()),
      selectedLocation: null,
      time: null,
      deadlineDate: null,
      startDate: null,
      description: "",
      nameEvent: "",
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
      selectedLocation: selectedLocation ?? this.selectedLocation,
      currentPage: currentPage ?? this.currentPage,
      startDate: startDate ?? this.startDate,
      deadlineDate: deadlineDate ?? this.deadlineDate,
      time: time ?? this.time,
      nameEvent: nameEvent ?? this.nameEvent,
      description: description ?? this.description,
    );
  }

  @override
  bool operator ==(covariant EditEventState other) {
    if (identical(this, other)) return true;

    return other.event == event &&
        other.selectedLocation == selectedLocation &&
        other.currentPage == currentPage &&
        other.startDate == startDate &&
        other.deadlineDate == deadlineDate &&
        other.time == time &&
        other.nameEvent == nameEvent &&
        other.description == description;
  }

  @override
  int get hashCode {
    return event.hashCode ^
        selectedLocation.hashCode ^
        currentPage.hashCode ^
        startDate.hashCode ^
        deadlineDate.hashCode ^
        time.hashCode ^
        nameEvent.hashCode ^
        description.hashCode;
  }
}
