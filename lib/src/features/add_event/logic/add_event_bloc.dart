import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:image_picker/image_picker.dart';

import 'package:myapp/src/features/add_event/logic/add_event_state.dart';

class AddEventBloc extends Cubit<AddEventState> {
  AddEventBloc() : super(AddEventState.ds());

  PageController controller = PageController(initialPage: 0);
  MapController mapController = MapController();

  void setCurrentPage(int index) {
    emit(state.copyWith(currentPage: index));
  }

  void selectMedias() async {
    final ImagePicker picker = ImagePicker();
    List<XFile> pickMedias = await picker.pickMultiImage(imageQuality: 5);

    if (state.medias.length < 5) {
      List<XFile?> newMedias = [...state.medias, ...pickMedias];
      if (newMedias.length > 5) {
        newMedias = [...newMedias.sublist(0, 5)];
      }
      emit(state.copyWith(medias: newMedias));
    } else {
      if (pickMedias.length > 5) {
        pickMedias = [...pickMedias.sublist(0, 5)];
      }
      emit(state.copyWith(medias: [...pickMedias]));
    }
  }

  void removeImage(int index) {
    final List<XFile?> newMedias = state.medias;
    newMedias.removeAt(index);
    emit(state.copyWith(medias: newMedias));
  }

  void handleTap(point) {
    emit(state.copyWith(selectedLocation: point));
  }

  void setNameEvent(value) {
    emit(state.copyWith(nameEvent: value));
  }

  void setDescriptionEvent(value) {
    emit(state.copyWith(description: value));
  }

  void setNumberMemberEvent(value) {
    emit(state.copyWith(numberMember: value));
  }

  void setStartDateEvent(value) {
    emit(state.copyWith(startDate: value));
  }

  void setDeadlineEvent(value) {
    emit(state.copyWith(deadlineDate: value));
  }

  void setTimeEvent(value) {
    emit(state.copyWith(time: value));
  }

  @override
  Future<void> close() {
    mapController.dispose();
    controller.dispose();
    return super.close();
  }
}
