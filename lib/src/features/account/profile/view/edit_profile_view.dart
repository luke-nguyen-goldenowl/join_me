import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/src/features/account/profile/logic/profile_bloc.dart';
import 'package:myapp/src/features/account/profile/widget/change_image_widget.dart';
import 'package:myapp/src/features/account/profile/widget/change_name_widget.dart';
import 'package:myapp/src/theme/colors.dart';
import 'package:myapp/widgets/appbar/app_bar_custom.dart';
import 'package:myapp/widgets/forms/input.dart';

class EditProfileView extends StatelessWidget {
  const EditProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProfileBloc(),
      child: Builder(builder: (context) {
        return Stack(
          children: [
            Scaffold(
              backgroundColor: AppColors.white,
              appBar: const AppBarCustom(
                title: Text("Edit Profile"),
              ),
              body: SingleChildScrollView(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const ChangeImage(),
                      const ShowEmail(),
                      const ChangeNameWidget(),
                      const SizedBox(height: 50),
                      ElevatedButton(
                        onPressed:
                            context.watch<ProfileBloc>().state.name.isNotEmpty
                                ? () {
                                    context.read<ProfileBloc>().updateUser();
                                  }
                                : null,
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 50),
                          backgroundColor: AppColors.rosyPink,
                          foregroundColor: AppColors.white,
                        ),
                        child: const Text(
                          "Save",
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            if (context.watch<ProfileBloc>().state.isSaving)
              Container(
                color: AppColors.black.withOpacity(0.5),
                height: double.infinity,
                width: double.infinity,
                alignment: Alignment.center,
                child: const CircularProgressIndicator(
                  color: AppColors.rosyPink,
                ),
              ),
          ],
        );
      }),
    );
  }
}

class ShowEmail extends StatelessWidget {
  const ShowEmail({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return XInput(
      key: const Key('email_textField'),
      value: context.watch<ProfileBloc>().state.email,
      readOnly: true,
      enabled: false,
      decoration: const InputDecoration(
        labelText: "Email",
      ),
    );
  }
}
