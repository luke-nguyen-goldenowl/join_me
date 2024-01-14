import 'package:flutter/material.dart';
import 'package:myapp/src/network/model/notification/follow_event.dart';
import 'package:myapp/src/theme/colors.dart';
import 'package:myapp/src/utils/date/date_helper.dart';
import 'package:myapp/widgets/image/image_network.dart';

class NotificationFollowEvent extends StatelessWidget {
  const NotificationFollowEvent(
      {super.key, required this.followEvent, this.dateTime});
  final DateTime? dateTime;
  final MFollowEvent followEvent;
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
                followEvent.user.avatar,
                height: 50,
                width: 50,
                fit: BoxFit.cover,
              ),
            ),
            title: Expanded(
              child: Text(
                '"${followEvent.user.name}"  has followed',
                style: const TextStyle(fontWeight: FontWeight.bold),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            subtitle: Expanded(
              child: Text(
                followEvent.event.name ?? "",
              ),
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
