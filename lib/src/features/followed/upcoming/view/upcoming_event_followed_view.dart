import 'package:flutter/material.dart';
import 'package:myapp/src/features/followed/widget/ticket.dart';

class UpcomingEventFollowedView extends StatelessWidget {
  const UpcomingEventFollowedView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 5,
        itemBuilder: ((context, index) {
          return const Ticket();
        }));
  }
}
