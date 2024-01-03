import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/src/features/account/profile/logic/profile_bloc.dart';
import 'package:myapp/widgets/forms/input.dart';

class ChangePasswordWidget extends StatelessWidget {
  const ChangePasswordWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        XInput(
          key: const Key('current_password_textField'),
          obscureText: true,
          value: context.watch<ProfileBloc>().state.currentPassword,
          onChanged: (value) {
            context.read<ProfileBloc>().setCurrentPassword(value);
          },
          decoration: const InputDecoration(
            labelText: "Current password",
          ),
        ),
        XInput(
          key: const Key('new_password_textField'),
          obscureText: true,
          value: context.watch<ProfileBloc>().state.newPassword,
          onChanged: (value) {
            context.read<ProfileBloc>().setNewPassword(value);
          },
          decoration: const InputDecoration(
            labelText: "New password",
          ),
        )
      ],
    );
  }
}
