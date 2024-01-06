import 'package:flutter/material.dart';
import 'package:myapp/src/network/model/notification/follow_user.dart';

class NotificationFollowUser extends StatelessWidget {
  const NotificationFollowUser({super.key, required this.followUser});

  final MFollowUser followUser;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.asset(
            followUser.user.avatar!,
            height: 50,
            width: 50,
            fit: BoxFit.cover,
          ),
        ),
        title: Text(
          '"${followUser.user.name}"  has followed you',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        onTap: () {
          // Xử lý khi người dùng chọn một thông báo
          print('Tapped on notification');
        },
      ),
    );
  }
}
