import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:myapp/src/features/add_event/logic/add_event_state.dart';

class AddEventBloc extends Cubit<AddEventState> {
  AddEventBloc() : super(AddEventState.ds());

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

  void setFormDetailEvent() {
    emit(state.copyWith(
      nameEvent: state.nameController.text,
      description: state.descriptionController.text,
      numberMember: int.tryParse(state.numberMemberController.text),
      startDate: DateFormat("dd/MM/yyyy hh:mm a")
          .parse("${state.dateController.text} ${state.timeController.text}"),
      deadlineDate:
          DateFormat("dd/MM/yyyy").parse(state.deadlineController.text),
    ));
  }

  @override
  Future<void> close() {
    state.controller.dispose();
    state.mapController.dispose();
    state.dateController.dispose();
    state.timeController.dispose();
    state.deadlineController.dispose();
    state.descriptionController.dispose();
    state.nameController.dispose();
    state.numberMemberController.dispose();
    return super.close();
  }
}
