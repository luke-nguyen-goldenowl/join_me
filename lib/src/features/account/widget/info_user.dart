import 'package:flutter/material.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:myapp/gen/assets.gen.dart';
import 'package:myapp/src/network/model/user/user.dart';
import 'package:myapp/src/theme/colors.dart';

class InfoUser extends StatelessWidget {
  const InfoUser({
    super.key,
    required this.user,
  });

  final MUser user;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      width: double.infinity,
      color: AppColors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 80,
            width: 80,
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                color: AppColors.white,
                border: const GradientBoxBorder(
                  gradient: LinearGradient(colors: AppColors.gradient),
                  width: 3,
                )),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: user.avatar == null || user.avatar!.isEmpty
                  ? Assets.images.images.avatar.image()
                  : Image.network(
                      user.avatar!,
                      fit: BoxFit.cover,
                    ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            user.name!,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            "${user.followers?.length.toString() ?? ""} followers",
            style: const TextStyle(
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }
}
