import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/src/features/home/logic/home_bloc.dart';
import 'package:myapp/src/features/home/logic/home_state.dart';
import 'package:myapp/src/features/home/widget/event_item_home.dart';
import 'package:myapp/src/features/home/widget/title_home.dart';

class ListEventHome extends StatelessWidget {
  const ListEventHome({super.key, required this.type});

  final TypeListEventHome type;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      buildWhen: (previous, current) {
        switch (type) {
          case TypeListEventHome.followed:
            return previous.followed.length != current.followed.length;
          case TypeListEventHome.popular:
            return previous.popular.length != current.popular.length;
          case TypeListEventHome.people:
            return previous.people.length != current.people.length;
          case TypeListEventHome.upcoming:
            return previous.upcoming.length != current.upcoming.length;
          default:
            return previous.followed.length != current.followed.length;
        }
      },
      builder: ((context, state) {
        final events = context.read<HomeBloc>().getListEvents(type);
        if (events.isNotEmpty) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TitleHome(title: type.text),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                height: 300,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: events.length,
                  itemBuilder: (context, index) {
                    return Row(
                      children: [
                        EventItemHome(
                          event: events[index],
                          index: index,
                          type: type,
                        ),
                        const SizedBox(width: 20),
                      ],
                    );
                  },
                ),
              )
            ],
          );
        } else {
          return const SizedBox(height: 5);
        }
      }),
    );
  }
}
