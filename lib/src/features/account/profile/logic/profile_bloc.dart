import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myapp/src/features/account/logic/account_bloc.dart';
import 'package:myapp/src/features/account/profile/logic/profile_state.dart';
import 'package:myapp/src/network/model/user/user.dart';
import 'package:myapp/src/services/image_picker.dart';

class ProfileBloc extends Cubit<ProfileState> {
  ProfileBloc() : super(ProfileState()) {
    final MUser user = GetIt.I<AccountBloc>().state.user;
    setName(user.name);
    setEmail(user.email);
  }

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
}
