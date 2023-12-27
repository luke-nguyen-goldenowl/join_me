import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/src/features/home/data/users.dart';
import 'package:myapp/src/features/home/story/logic/story_view_bloc.dart';
import 'package:myapp/src/features/home/story/logic/story_view_state.dart';
import 'package:myapp/src/features/home/story/widget/story_widget.dart';

class StoryView extends StatelessWidget {
  const StoryView({super.key, required this.id});
  final String id;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => StoryViewBloc(
        (StoryViewState(user: users.firstWhere((element) => element.id == id))),
      ),
      child: BlocBuilder<StoryViewBloc, StoryViewState>(
        buildWhen: (previous, current) => previous.user != current.user,
        builder: (context, state) {
          return PageView(
            controller: context.read<StoryViewBloc>().controller,
            onPageChanged: ((value) {
              print('chuyển page nè $value');
            }),
            children: users
                .map((user) => StoryWidget(
                      user: user,
                      controller: context.read<StoryViewBloc>().controller,
                    ))
                .toList(),
          );
        },
      ),
    );
  }
}
