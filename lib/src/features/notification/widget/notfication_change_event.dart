import 'package:flutter/material.dart';
import 'package:myapp/src/network/model/notification/change_event.dart';
import 'package:myapp/src/theme/colors.dart';
import 'package:myapp/src/utils/date/date_helper.dart';
import 'package:myapp/widgets/image/image_network.dart';

class NotificationChangeEvent extends StatelessWidget {
  const NotificationChangeEvent(
      {super.key, required this.changeEvent, this.dateTime});
  final DateTime? dateTime;
  final MChangeEvent changeEvent;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          ListTile(
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: XImageNetwork(
                changeEvent.event.images?[0],
                height: 50,
                width: 50,
                fit: BoxFit.cover,
              ),
            ),
            title: Row(
              children: [
                Expanded(
                  child: Text(
                    '${changeEvent.event.name}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            subtitle: const Row(
              children: [
                Expanded(
                  child: Text(
                    'has been adjusted',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
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
