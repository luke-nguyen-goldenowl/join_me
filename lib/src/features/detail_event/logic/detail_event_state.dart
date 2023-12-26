import 'package:flutter/material.dart';

class DetailEventState {
  PageController controller;
  int indexPageImage;

  DetailEventState({required this.controller, required this.indexPageImage});

  factory DetailEventState.ds() {
    return DetailEventState(controller: PageController(), indexPageImage: 0);
  }

  DetailEventState copyWith({indexPageImage}) {
    return DetailEventState(
      controller: controller,
      indexPageImage: indexPageImage ?? this.indexPageImage,
    );
  }
}
