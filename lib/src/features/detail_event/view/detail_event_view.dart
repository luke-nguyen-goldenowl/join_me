import 'package:flutter/material.dart';

class DetailEventView extends StatelessWidget {
  const DetailEventView({super.key, required this.id});
  final String id;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Event view"),
      ),
      body: Center(
        child: Text(id),
      ),
    );
  }
}
