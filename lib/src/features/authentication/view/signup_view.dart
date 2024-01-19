import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:myapp/gen/assets.gen.dart';
import 'package:myapp/src/features/authentication/logic/signup_bloc.dart';
import 'package:myapp/src/localization/localization_utils.dart';
import 'package:myapp/src/theme/colors.dart';
import 'package:myapp/widgets/button/button.dart';
import 'package:myapp/widgets/forms/input.dart';

class SignupView extends StatelessWidget {
  const SignupView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SignupBloc(),
      child: BlocBuilder<SignupBloc, SignupState>(
        builder: (context, SignupState state) {
          return SafeArea(
            child: Scaffold(
              appBar: AppBar(
                foregroundColor: AppColors.rosyPink,
                backgroundColor: AppColors.white,
              ),
              backgroundColor: AppColors.white,
              body: Container(
                padding: const EdgeInsets.fromLTRB(24, 0, 24, 20),
                child: SingleChildScrollView(
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  child: _builder(context, state),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _builder(BuildContext context, SignupState state) {
    return Column(
      // crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(20.0),
          child: Assets.images.images.logo.image(
            fit: BoxFit.cover,
            height: 100,
            width: 100,
          ),
        ),
        const Text(
          "SIGN UP",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.bold,
            color: AppColors.text,
          ),
        ),
        const SizedBox(height: 24.0),
        XInput(
          key: const Key('loginForm_NameInput_textField'),
          value: state.name.value,
          onChanged: context.read<SignupBloc>().onNameChanged,
          keyboardType: TextInputType.name,
          decoration: InputDecoration(
            labelText: 'Username',
            hintText: 'Username',
            errorText: state.name.errorOf(context),
          ),
        ),
        const SizedBox(height: 8.0),
        XInput(
          key: const Key('loginForm_emailInput_textField'),
          value: state.email.value,
          onChanged: context.read<SignupBloc>().onEmailChanged,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            labelText: 'Email',
            hintText: 'Email',
            errorText: state.email.errorOf(context),
          ),
        ),
        const SizedBox(height: 8.0),
        XInput(
          value: state.password.value,
          key: const Key('loginForm_passwordInput_textField'),
          onChanged: context.read<SignupBloc>().onPasswordChanged,
          obscureText: true,
          decoration: InputDecoration(
            hintText: 'Password',
            errorText: state.password.errorOf(context),
          ),
        ),
        const SizedBox(height: 32.0),
        SizedBox(
          width: double.infinity,
          child: XButton(
            busy: state.status.isInProgress,
            enabled: state.isValidated,
            title: S.of(context).common_next,
            onPressed: () =>
                context.read<SignupBloc>().signupWithEmail(context),
          ),
        ),
        const SizedBox(height: 16.0),
      ],
    );
  }
}
