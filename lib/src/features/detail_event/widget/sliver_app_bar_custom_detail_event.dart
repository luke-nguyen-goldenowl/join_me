import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/src/features/detail_event/logic/detail_event_bloc.dart';
import 'package:myapp/src/features/detail_event/widget/background_widget.dart';
import 'package:myapp/src/theme/colors.dart';

class SliverAppBarCustomDetailEvent extends StatelessWidget {
  const SliverAppBarCustomDetailEvent({
    super.key,
    required this.images,
  });

  final List<String> images;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      foregroundColor: AppColors.white,
      expandedHeight: 200,
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.favorite_border),
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
                    images[
                        context.watch<DetailEventBloc>().state.indexPageImage],
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
  }
}
