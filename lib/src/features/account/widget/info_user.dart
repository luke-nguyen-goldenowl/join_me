import 'package:flutter/material.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:myapp/src/network/model/user/user.dart';
import 'package:myapp/src/theme/colors.dart';
import 'package:myapp/widgets/image/image_network.dart';

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
              child: XImageNetwork(
                user.avatar,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            user.name ?? "",
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "12 Events",
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
              SizedBox(width: 20),
              Text(
                "200 Follower",
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
