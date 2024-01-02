import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/src/features/account/profile/logic/profile_bloc.dart';
import 'package:myapp/src/theme/colors.dart';
import 'package:myapp/widgets/forms/input.dart';

class ChangeNameWidget extends StatelessWidget {
  const ChangeNameWidget({
    super.key,
    required this.profileBlocContext,
  });

  final BuildContext profileBlocContext;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            "Change Name",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          XInput(
            key: const Key('change_user_name_textField'),
            value: profileBlocContext.watch<ProfileBloc>().state.name,
            onChanged: (value) {
              profileBlocContext.read<ProfileBloc>().setName(value);
            },
            decoration: const InputDecoration(
              labelText: "Name",
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(100, 50),
                  backgroundColor: AppColors.white,
                  foregroundColor: AppColors.rosyPink,
                ),
                child: const Text("Cancel"),
              ),
              const SizedBox(width: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(100, 50),
                  backgroundColor: AppColors.rosyPink,
                  foregroundColor: AppColors.white,
                ),
                child: const Text("Save"),
              ),
            ],
          )
        ],
      ),
    );
  }
}
