// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:myapp/src/network/model/event/event.dart';
import 'package:myapp/src/utils/utils.dart';

class AddEventState {
  int currentPage;
  bool isPosting;
  bool isLoadingCurrentLocation;

  bool isSearching;
  String searchAddress;

  MEvent event;
  List<XFile?> medias;
  TimeOfDay? time;

  AddEventState({
    required this.currentPage,
    required this.isPosting,
    required this.isLoadingCurrentLocation,
    required this.isSearching,
    required this.searchAddress,
    required this.event,
    required this.medias,
    required this.time,
  });

  factory AddEventState.ds([MEvent? event]) {
    return AddEventState(
      currentPage: 0,
      medias: [],
      time: (event != null && event.startDate != null)
          ? TimeOfDay.fromDateTime(event.startDate!)
          : null,
      isPosting: false,
      isLoadingCurrentLocation: true,
      event: event ?? MEvent.empty(),
      searchAddress: "",
      isSearching: false,
    );
  }

  bool checkValidate() {
    if (currentPage == 0 && medias.isEmpty && isNullOrEmpty(event.images)) {
      return false;
    }
    if (currentPage == 1 && (event.location == null || searchAddress.isEmpty)) {
      return false;
    }
    if (currentPage == 2 &&
        (time == null ||
            event.deadline == null ||
            event.startDate == null ||
            event.type == null ||
            isNullOrEmpty(event.description) ||
            isNullOrEmpty(event.name))) {
      return false;
    }

    return true;
  }

  AddEventState copyWith({
    int? currentPage,
    bool? isPosting,
    bool? isLoadingCurrentLocation,
    bool? isSearching,
    String? searchAddress,
    MEvent? event,
    List<XFile?>? medias,
    TimeOfDay? time,
  }) {
    return AddEventState(
      currentPage: currentPage ?? this.currentPage,
      isPosting: isPosting ?? this.isPosting,
      isLoadingCurrentLocation:
          isLoadingCurrentLocation ?? this.isLoadingCurrentLocation,
      isSearching: isSearching ?? this.isSearching,
      searchAddress: searchAddress ?? this.searchAddress,
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
        other.isSearching == isSearching &&
        other.searchAddress == searchAddress &&
        other.event == event &&
        listEquals(other.medias, medias) &&
        other.time == time;
  }

  @override
  int get hashCode {
    return currentPage.hashCode ^
        isPosting.hashCode ^
        isLoadingCurrentLocation.hashCode ^
        isSearching.hashCode ^
        searchAddress.hashCode ^
        event.hashCode ^
        medias.hashCode ^
        time.hashCode;
  }
}
