import 'package:flutter/material.dart';
import 'package:myapp/src/network/model/notification/change_event.dart';
import 'package:myapp/src/theme/colors.dart';
import 'package:myapp/src/utils/date/date_helper.dart';
import 'package:myapp/widgets/image/image_network.dart';

class NotificationNewEvent extends StatelessWidget {
  const NotificationNewEvent(
      {super.key, required this.changeEvent, required this.dateTime});

  final MChangeEvent changeEvent;
  final DateTime? dateTime;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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
            subtitle: Row(
              children: [
                Expanded(
                  child: Text(
                    'has been created by ${changeEvent.host.name ?? ""}',
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
