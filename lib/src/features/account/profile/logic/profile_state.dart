// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:image_picker/image_picker.dart';

class ProfileState {
  String name;
  String newPassword;
  String currentPassword;
  XFile? avatar;
  ProfileState({
    this.name = "",
    this.newPassword = "",
    this.currentPassword = "",
    this.avatar,
  });

  ProfileState copyWith({
    String? name,
    String? newPassword,
    String? currentPassword,
    XFile? avatar,
  }) {
    return ProfileState(
      name: name ?? this.name,
      newPassword: newPassword ?? this.newPassword,
      currentPassword: currentPassword ?? this.currentPassword,
      avatar: avatar ?? this.avatar,
    );
  }

  @override
  bool operator ==(covariant ProfileState other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.newPassword == newPassword &&
        other.currentPassword == currentPassword &&
        other.avatar == avatar;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        newPassword.hashCode ^
        currentPassword.hashCode ^
        avatar.hashCode;
  }
}
