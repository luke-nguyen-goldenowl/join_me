import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:myapp/src/network/model/notification/upcoming_event.dart';

class NotificationUpcomingEvent extends StatelessWidget {
  const NotificationUpcomingEvent({super.key, required this.upcomingEvent});

  final MUpcomingEvent upcomingEvent;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.asset(
            upcomingEvent.event.images?[0] ?? "",
            height: 50,
            width: 50,
            fit: BoxFit.cover,
          ),
        ),
        title: Expanded(
          child: Text(
            'Event "${upcomingEvent.event.name}" will take place on ${DateFormat('dd/MM/yyyy HH:MM a').format(upcomingEvent.event.startDate!)}',
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
