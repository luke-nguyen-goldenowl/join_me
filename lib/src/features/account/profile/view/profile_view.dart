import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:myapp/src/features/account/logic/account_bloc.dart';
import 'package:myapp/src/features/account/profile/logic/profile_bloc.dart';
import 'package:myapp/src/features/account/profile/logic/profile_state.dart';
import 'package:myapp/src/features/account/profile/widget/change_name_widget.dart';
import 'package:myapp/src/router/coordinator.dart';
import 'package:myapp/src/theme/colors.dart';
import 'package:myapp/widgets/card/card.dart';
import 'package:myapp/widgets/card/card_section.dart';
import 'package:myapp/widgets/forms/input.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => ProfileBloc()
          ..setName(context.watch<AccountBloc>().state.user.name!),
        child: BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                elevation: 0,
                backgroundColor: Colors.transparent,
                foregroundColor: Colors.black87,
              ),
              body: Container(
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    XCardSection(
                      children: [
                        XCardSectionButton(
                          title: 'Change avatar',
                          onTap: () {
                            _handleChangeAvatar(context);
                          },
                        ),
                        XCardSectionButton(
                          title: 'Change name',
                          onTap: (() {
                            _handleChangeName(context);
                          }),
                        ),
                        XCardSectionButton(
                          title: 'Change password',
                          onTap: () {},
                        ),
                      ],
                    ),
                    const SizedBox(height: 46),
                    InkWell(
                      onTap: () async {
                        final result =
                            await context.read<AccountBloc>().onLogOut(context);
                        if (result == true) {
                          // ignore: use_build_context_synchronously
                          AppCoordinator.showSignInScreen();
                        }
                      },
                      child: const XCard(
                        child: Text(
                          'Logout',
                          style: TextStyle(color: Color(0xFFC94A28)),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    InkWell(
                      onTap: () async {
                        final result = await context
                            .read<AccountBloc>()
                            .onRemoveAccount(context);
                        if (result == true) {
                          // ignore: use_build_context_synchronously
                          AppCoordinator.pop();
                        }
                      },
                      child: const XCard(
                        child: Text(
                          'Remove Account',
                          style: TextStyle(color: Color(0xFFC94A28)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ));
  }

  void _handleChangeName(
    BuildContext context,
  ) {
    showMaterialModalBottomSheet(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        backgroundColor: AppColors.iceBlue,
        context: context,
        builder: (contextModal) {
          return ChangeNameWidget(
            profileBlocContext: context,
          );
        });
  }

  void _handleChangeAvatar(
    BuildContext context,
  ) {
    showMaterialModalBottomSheet(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        backgroundColor: AppColors.iceBlue,
        context: context,
        builder: (contextModal) {
          return Container(
            height: 500,
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Change Avatar",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    IconButtonOpenImage(
                      icon: const Icon(Icons.camera_alt),
                      handlePress: () {},
                    ),
                    const SizedBox(width: 20),
                    IconButtonOpenImage(
                      icon: const Icon(Icons.image),
                      handlePress: () {},
                    ),
                  ],
                )
              ],
            ),
          );
        });
  }
}

class IconButtonOpenImage extends StatelessWidget {
  const IconButtonOpenImage({
    super.key,
    required this.handlePress,
    required this.icon,
  });

  final Icon icon;
  final Function() handlePress;

  @override
  Widget build(BuildContext context) {
    return IconButton.filled(
      style: IconButton.styleFrom(
          backgroundColor: AppColors.black.withOpacity(0.2),
          foregroundColor: AppColors.white.withOpacity(0.8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          minimumSize: const Size(60, 60)),
      onPressed: handlePress,
      icon: icon,
      iconSize: 40,
    );
  }
}
