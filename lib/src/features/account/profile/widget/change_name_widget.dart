import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/src/features/account/profile/logic/profile_bloc.dart';
import 'package:myapp/src/features/account/profile/logic/profile_state.dart';
import 'package:myapp/widgets/forms/input.dart';

class ChangeNameWidget extends StatelessWidget {
  const ChangeNameWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      buildWhen: (previous, current) => previous.name != current.name,
      builder: ((context, state) {
        return XInput(
          key: const Key('change_user_name_textField'),
          value: state.name,
          onChanged: (value) {
            context.read<ProfileBloc>().setName(value);
          },
          decoration: const InputDecoration(
            labelText: "Name",
          ),
        );
      }),
    );
  }
}
