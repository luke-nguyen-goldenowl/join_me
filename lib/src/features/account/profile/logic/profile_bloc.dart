import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myapp/src/dialogs/alert_wrapper.dart';
import 'package:myapp/src/dialogs/toast_wrapper.dart';
import 'package:myapp/src/features/account/logic/account_bloc.dart';
import 'package:myapp/src/features/account/profile/logic/profile_state.dart';
import 'package:myapp/src/network/domain_manager.dart';
import 'package:myapp/src/network/model/user/user.dart';
import 'package:myapp/src/router/coordinator.dart';
import 'package:myapp/src/services/image_picker.dart';

class ProfileBloc extends Cubit<ProfileState> {
  ProfileBloc() : super(ProfileState()) {
    setName(user.name);
    setEmail(user.email);
  }
  final MUser user = GetIt.I<AccountBloc>().state.user;

  void setName(String? name) {
    emit(state.copyWith(name: name));
  }

  void setEmail(String? email) {
    emit(state.copyWith(email: email));
  }

  void pickImage() async {
    final XFile? image = await XImagePicker().onPickImage();
    emit(state.copyWith(avatar: image));
  }

  void clearImage() {
    emit(state.copyWith(avatar: null));
  }

  void updateUser() async {
    if (!isClosed) emit(state.copyWith(isSaving: true));
    final result = await DomainManager()
        .sign
        .updateProfile(state.avatar?.path, state.name);
    if (!isClosed) emit(state.copyWith(isSaving: false));
    if (result.isSuccess) {
      if (!isClosed) {
        GetIt.I<AccountBloc>().emit(
          GetIt.I<AccountBloc>().state.copyWith(
                user: user.copyWith(
                  avatar:
                      result.data ?? GetIt.I<AccountBloc>().state.user.avatar,
                  name: state.name,
                ),
              ),
        );
      }
      AppCoordinator.pop();
      XToast.success('Update user success');
    } else {
      XAlert.show(title: 'Update user fail', body: result.error);
    }
  }
}
