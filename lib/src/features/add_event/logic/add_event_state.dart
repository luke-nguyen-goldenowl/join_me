// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:latlong2/latlong.dart';

import 'package:myapp/src/network/model/event/event.dart';

class AddEventState {
  int currentPage;
  bool isPosting;
  bool isLoadingCurrentLocation;

  LatLng? selectedLocation;
  List<XFile?> medias;
  DateTime? startDate;
  DateTime? deadlineDate;
  TimeOfDay? time;
  TypeEvent? typeEvent;
  String nameEvent;
  String description;
  int numberMember;

  AddEventState({
    required this.currentPage,
    required this.isPosting,
    required this.selectedLocation,
    required this.medias,
    required this.startDate,
    required this.deadlineDate,
    required this.time,
    required this.typeEvent,
    required this.nameEvent,
    required this.description,
    required this.numberMember,
    required this.isLoadingCurrentLocation,
  });

  factory AddEventState.ds() {
    return AddEventState(
      currentPage: 0,
      medias: [],
      selectedLocation: null,
      time: null,
      deadlineDate: null,
      startDate: null,
      description: "",
      nameEvent: "",
      numberMember: 0,
      typeEvent: null,
      isPosting: false,
      isLoadingCurrentLocation: true,
    );
  }

  bool checkValidate() {
    if (currentPage == 0 && medias.isEmpty) {
      return false;
    }
    if (currentPage == 1 && selectedLocation == null) {
      return false;
    }
    if (currentPage == 2 &&
        (time == null ||
            deadlineDate == null ||
            startDate == null ||
            typeEvent == null ||
            description.isEmpty ||
            nameEvent.isEmpty ||
            numberMember <= 0)) {
      return false;
    }

    return true;
  }

  AddEventState copyWith({
    int? currentPage,
    bool? isPosting,
    LatLng? selectedLocation,
    List<XFile?>? medias,
    DateTime? startDate,
    DateTime? deadlineDate,
    TimeOfDay? time,
    TypeEvent? typeEvent,
    String? nameEvent,
    String? description,
    int? numberMember,
    bool? isLoadingCurrentLocation,
  }) {
    return AddEventState(
      currentPage: currentPage ?? this.currentPage,
      isPosting: isPosting ?? this.isPosting,
      selectedLocation: selectedLocation ?? this.selectedLocation,
      medias: medias ?? this.medias,
      startDate: startDate ?? this.startDate,
      deadlineDate: deadlineDate ?? this.deadlineDate,
      time: time ?? this.time,
      typeEvent: typeEvent ?? this.typeEvent,
      nameEvent: nameEvent ?? this.nameEvent,
      description: description ?? this.description,
      numberMember: numberMember ?? this.numberMember,
      isLoadingCurrentLocation:
          isLoadingCurrentLocation ?? this.isLoadingCurrentLocation,
    );
  }
}
