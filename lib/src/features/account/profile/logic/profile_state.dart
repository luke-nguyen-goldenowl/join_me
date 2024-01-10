// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:image_picker/image_picker.dart';

class ProfileState {
  bool isSaving;
  String name;
  String email;
  XFile? avatar;
  ProfileState({
    this.isSaving = false,
    this.name = "",
    this.email = "undefine",
    this.avatar,
  });

  ProfileState copyWith({
    bool? isSaving,
    String? name,
    String? email,
    XFile? avatar,
  }) {
    return ProfileState(
      isSaving: isSaving ?? this.isSaving,
      name: name ?? this.name,
      email: email ?? this.email,
      avatar: avatar ?? this.avatar,
    );
  }

  @override
  bool operator ==(covariant ProfileState other) {
    if (identical(this, other)) return true;

    return other.isSaving == isSaving &&
        other.name == name &&
        other.email == email &&
        other.avatar == avatar;
  }

  @override
  int get hashCode {
    return isSaving.hashCode ^ name.hashCode ^ email.hashCode ^ avatar.hashCode;
  }
}
