import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:myapp/gen/assets.gen.dart';
import 'package:myapp/src/features/authentication/logic/signin_bloc.dart';
import 'package:myapp/src/features/authentication/widget/social_list_button.dart';
import 'package:myapp/src/network/model/social_type.dart';
import 'package:myapp/src/router/coordinator.dart';
import 'package:myapp/src/theme/colors.dart';
import 'package:myapp/widgets/button/button.dart';
import 'package:myapp/widgets/forms/input.dart';

class SigninView extends StatelessWidget {
  const SigninView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SigninBloc(),
      child: Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        body: Container(
          padding: const EdgeInsets.fromLTRB(24, 0, 24, 20),
          child: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.manual,
            child: BlocBuilder<SigninBloc, SigninState>(builder: _builder),
          ),
        ),
      ),
    );
  }

  Widget _builder(BuildContext context, SigninState state) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(height: 30),
        InkWell(
          onLongPress: () {
            FirebaseCrashlytics.instance.crash();
          },
          child: Assets.images.images.logo.image(
            fit: BoxFit.cover,
            height: 150,
            width: 150,
          ),
        ),
        _buildTitle(context),
        const SizedBox(height: 24.0),
        XInput(
          key: const Key('loginForm_emailAndPhoneInput_textField'),
          value: state.email.value,
          onChanged: context.read<SigninBloc>().onEmailChanged,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
              labelText: "Email", errorText: state.email.errorOf(context)),
        ),
        const SizedBox(height: 16.0),
        XInput(
          key: const Key('loginForm_passwordInput_textField'),
          value: state.password.value,
          onChanged: context.read<SigninBloc>().onPasswordChanged,
          obscureText: true,
          decoration: InputDecoration(
              labelText: 'Password',
              errorText: state.password.errorOf(context)),
        ),
        const SizedBox(height: 30.0),
        SizedBox(
          width: double.infinity,
          child: XButton(
            key: const Key('loginForm_continue_raisedButton'),
            busy: state.status.isInProgress &&
                state.loginType == MSocialType.email,
            enabled: state.isValidated,
            title: "Login", //S.of(context).common_next,
            onPressed: () async {
              context.read<SigninBloc>().loginWithEmail(context);
            },
          ),
        ),
        const SizedBox(height: 32.0),
        const SocialListButton(),
        const SizedBox(height: 32.0),
        _buildNoAccount(context),
      ],
    );
  }

  Widget _buildTitle(BuildContext context) {
    return RichText(
        textAlign: TextAlign.center,
        text: const TextSpan(children: [
          TextSpan(
            text: "Welcome to ",
            style: TextStyle(
              color: AppColors.text,
              fontSize: 30,
            ),
          ),
          TextSpan(
            text: "JoinUs!",
            style: TextStyle(
                color: AppColors.rosyPink,
                fontSize: 40,
                fontWeight: FontWeight.bold),
          )
        ]));
  }

  Widget _buildNoAccount(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        children: [
          const TextSpan(
            text: "Not have account?" '  ',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16,
              color: AppColors.textSecondary,
              letterSpacing: 0.24,
            ),
          ),
          TextSpan(
            text: "Signup now",
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16,
              color: AppColors.rosyPink,
              letterSpacing: 0.24,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = AppCoordinator.showSignUpScreen,
          ),
        ],
      ),
    );
  }
}
