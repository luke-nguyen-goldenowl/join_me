import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/src/features/home/logic/event_item_bloc.dart';
import 'package:myapp/src/features/home/widget/event_item_home.dart';
import 'package:myapp/src/features/home/widget/title_home.dart';

class ListEventHome extends StatelessWidget {
  const ListEventHome({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TitleHome(title: title),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          height: 300,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 20,
            itemBuilder: (context, index) {
              return BlocProvider(
                create: (_) => EventItemBloc()..initIsLike(Random().nextBool()),
                child: Row(
                  children: [
                    EventItemHome(
                      id: 'uWbVA0CkBqVxhYZ5QHYT',
                    ),
                    const SizedBox(width: 20),
                  ],
                ),
              );
            },
          ),
        )
      ],
    );
  }
}
