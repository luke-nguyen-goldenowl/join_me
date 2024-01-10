import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:myapp/src/features/account/logic/account_bloc.dart';
import 'package:myapp/src/features/account/profile/logic/profile_bloc.dart';
import 'package:myapp/src/features/account/profile/logic/profile_state.dart';
import 'package:myapp/src/theme/colors.dart';
import 'package:myapp/widgets/image/image_network.dart';

class ChangeImage extends StatelessWidget {
  const ChangeImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      buildWhen: (previous, current) => previous.avatar != current.avatar,
      builder: ((context, state) {
        return Center(
          child: Stack(
            children: [
              Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    color: AppColors.grey,
                    width: 2,
                    style: BorderStyle.solid,
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: state.avatar != null
                      ? Image.file(
                          File(state.avatar!.path),
                          fit: BoxFit.cover,
                        )
                      : XImageNetwork(GetIt.I<AccountBloc>().state.user.avatar),
                ),
              ),
              InkWell(
                onTap: () {
                  context.read<ProfileBloc>().pickImage();
                },
                child: Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: AppColors.black.withOpacity(0.4)),
                  child: Icon(
                    Icons.camera_alt_outlined,
                    size: 40,
                    color: AppColors.white.withOpacity(0.8),
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
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
          minimumSize: const Size(50, 50)),
      onPressed: handlePress,
      icon: icon,
      iconSize: 30,
    );
  }
}
