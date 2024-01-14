import 'package:flutter/material.dart';
import 'package:myapp/src/network/model/notification/follow_user.dart';
import 'package:myapp/src/theme/colors.dart';
import 'package:myapp/src/utils/date/date_helper.dart';
import 'package:myapp/widgets/image/image_network.dart';

class NotificationFollowUser extends StatelessWidget {
  const NotificationFollowUser(
      {super.key, required this.followUser, this.dateTime});
  final DateTime? dateTime;
  final MFollowUser followUser;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      padding: const EdgeInsets.only(top: 10),
      decoration: const BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        children: [
          ListTile(
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: XImageNetwork(
                followUser.follower.avatar,
                height: 50,
                width: 50,
                fit: BoxFit.cover,
              ),
            ),
            title: Text(
              '"${followUser.follower.name}"  has followed you',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Text(
            DateHelper.getFullDateTime(dateTime),
            style: const TextStyle(
              color: AppColors.grey,
            ),
          )
        ],
      ),
    );
  }
}
