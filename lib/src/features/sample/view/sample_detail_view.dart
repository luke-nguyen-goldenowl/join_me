import 'package:flutter/material.dart';
import 'package:myapp/src/router/coordinator.dart';

class SampleItemDetailsView extends StatelessWidget {
  const SampleItemDetailsView({required this.id, super.key});
  final String id;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Item Details'),
      ),
      body: Center(
        child: TextButton(
            onPressed: () {
              AppCoordinator.pop(true);
            },
            child: const Text("Back")),
      ),
    );
  }
}
