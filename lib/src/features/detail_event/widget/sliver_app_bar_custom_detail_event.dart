import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:myapp/src/features/account/logic/account_bloc.dart';
import 'package:myapp/src/features/detail_event/logic/detail_event_bloc.dart';
import 'package:myapp/src/features/detail_event/logic/detail_event_state.dart';
import 'package:myapp/src/features/detail_event/widget/background_widget.dart';
import 'package:myapp/src/theme/colors.dart';

class SliverAppBarCustomDetailEvent extends StatelessWidget {
  const SliverAppBarCustomDetailEvent({
    super.key,
    required this.images,
    required this.favorites,
  });

  final List<String> images;
  final List<String> favorites;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DetailEventBloc, DetailEventState>(
      buildWhen: (previous, current) =>
          previous.indexPageImage != previous.indexPageImage ||
          previous.event != previous.event,
      builder: (context, state) {
        return SliverAppBar(
          pinned: true,
          foregroundColor: AppColors.white,
          expandedHeight: 200,
          actions: [
            IconButton(
              onPressed: () {
                context.read<DetailEventBloc>().onPressedFavoriteEvent();
              },
              icon: favorites.contains(GetIt.I<AccountBloc>().state.user.id)
                  ? const Icon(
                      Icons.favorite,
                      color: AppColors.rosyPink,
                    )
                  : const Icon(Icons.favorite_border),
            )
          ],
          flexibleSpace: Stack(
            children: <Widget>[
              Positioned.fill(
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    if (images.isNotEmpty)
                      Image.network(
                        images[state.indexPageImage],
                        fit: BoxFit.cover,
                      ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.8),
                      ),
                    ),
                  ],
                ),
              ),
              FlexibleSpaceBar(
                background: BackgroundWidget(
                  images: images,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
