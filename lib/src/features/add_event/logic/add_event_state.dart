// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:myapp/src/network/model/event/event.dart';

class AddEventState {
  int currentPage;
  bool isPosting;
  bool isLoadingCurrentLocation;

  MEvent event;
  List<XFile?> medias;
  TimeOfDay? time;

  AddEventState({
    required this.currentPage,
    required this.isPosting,
    required this.medias,
    required this.time,
    required this.isLoadingCurrentLocation,
    required this.event,
  });

  factory AddEventState.ds() {
    return AddEventState(
      currentPage: 0,
      medias: [],
      time: null,
      isPosting: false,
      isLoadingCurrentLocation: true,
      event: MEvent(),
    );
  }

  bool checkValidate() {
    if (currentPage == 0 && medias.isEmpty) {
      return false;
    }
    if (currentPage == 1 && event.location == null) {
      return false;
    }
    if (currentPage == 2 &&
        (time == null ||
            event.deadline == null ||
            event.startDate == null ||
            event.type == null ||
            event.description == null ||
            (event.description?.isEmpty ?? true) ||
            event.name == null ||
            (event.name?.isEmpty ?? true))) {
      return false;
    }

    return true;
  }

  AddEventState copyWith({
    int? currentPage,
    bool? isPosting,
    bool? isLoadingCurrentLocation,
    MEvent? event,
    List<XFile?>? medias,
    TimeOfDay? time,
  }) {
    return AddEventState(
      currentPage: currentPage ?? this.currentPage,
      isPosting: isPosting ?? this.isPosting,
      isLoadingCurrentLocation:
          isLoadingCurrentLocation ?? this.isLoadingCurrentLocation,
      event: event ?? this.event,
      medias: medias ?? this.medias,
      time: time ?? this.time,
    );
  }

  @override
  bool operator ==(covariant AddEventState other) {
    if (identical(this, other)) return true;

    return other.currentPage == currentPage &&
        other.isPosting == isPosting &&
        other.isLoadingCurrentLocation == isLoadingCurrentLocation &&
        other.event == event &&
        listEquals(other.medias, medias) &&
        other.time == time;
  }

  @override
  int get hashCode {
    return currentPage.hashCode ^
        isPosting.hashCode ^
        isLoadingCurrentLocation.hashCode ^
        event.hashCode ^
        medias.hashCode ^
        time.hashCode;
  }
}
