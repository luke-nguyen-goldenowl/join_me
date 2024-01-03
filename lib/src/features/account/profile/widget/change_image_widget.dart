import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:myapp/src/features/account/profile/logic/profile_bloc.dart';
import 'package:myapp/src/theme/colors.dart';

class ChangeImage extends StatelessWidget {
  const ChangeImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
            child: context.watch<ProfileBloc>().state.avatar != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.file(
                      File(context.watch<ProfileBloc>().state.avatar!.path),
                      fit: BoxFit.cover,
                    ),
                  )
                : const Center(
                    child: Icon(
                      Icons.person,
                      size: 70,
                      color: AppColors.rosyPink,
                    ),
                  ),
          ),
          InkWell(
            onTap: () {
              _handleSetImage(context);
            },
            child: Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: AppColors.black.withOpacity(0.5)),
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

void _handleSetImage(
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
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  IconButtonOpenImage(
                    icon: const Icon(Icons.camera_alt),
                    handlePress: () {
                      context.read<ProfileBloc>().pickImage(ImageSource.camera);
                      Navigator.pop(context);
                    },
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    "Camera",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  IconButtonOpenImage(
                    icon: const Icon(Icons.image),
                    handlePress: () {
                      context
                          .read<ProfileBloc>()
                          .pickImage(ImageSource.gallery);
                      Navigator.pop(context);
                    },
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    "Gallery",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      });
}
