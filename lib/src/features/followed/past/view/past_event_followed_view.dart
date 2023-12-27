import 'package:flutter/material.dart';
import 'package:myapp/src/features/followed/widget/ticket.dart';

class PastEventFollowedView extends StatelessWidget {
  const PastEventFollowedView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 5,
        itemBuilder: ((context, index) {
          return const Ticket();
        }));
  }
}
