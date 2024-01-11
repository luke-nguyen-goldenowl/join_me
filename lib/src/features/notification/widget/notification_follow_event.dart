import 'package:flutter/material.dart';
import 'package:myapp/src/network/model/notification/follow_event.dart';

class NotificationFollowEvent extends StatelessWidget {
  const NotificationFollowEvent({super.key, required this.followEvent});

  final MFollowEvent followEvent;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.asset(
            followEvent.user.avatar!,
            height: 50,
            width: 50,
            fit: BoxFit.cover,
          ),
        ),
        title: Expanded(
          child: Text(
            ' "${followEvent.user.name}"  has followed your event (${followEvent.event.name})',
            style: const TextStyle(fontWeight: FontWeight.bold),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        onTap: () {
          // Xử lý khi người dùng chọn một thông báo
          print('Tapped on notification');
        },
      ),
    );
  }
}
