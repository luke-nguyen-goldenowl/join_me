import 'package:flutter/material.dart';
import 'package:myapp/src/network/model/notification/change_event.dart';

class NotificationChangeEvent extends StatelessWidget {
  const NotificationChangeEvent({super.key, required this.changeEvent});

  final MChangeEvent changeEvent;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.asset(
            changeEvent.event.images[0],
            height: 50,
            width: 50,
            fit: BoxFit.cover,
          ),
        ),
        title: Expanded(
          child: Text(
            'Event "${changeEvent.event.name}" has been adjusted',
            style: const TextStyle(fontWeight: FontWeight.bold),
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
