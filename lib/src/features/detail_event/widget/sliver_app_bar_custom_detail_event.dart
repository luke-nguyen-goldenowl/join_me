import 'package:flutter/material.dart';
import 'package:myapp/gen/assets.gen.dart';
import 'package:myapp/src/features/detail_event/widget/background_widget.dart';
import 'package:myapp/src/theme/colors.dart';

class SliverAppBarCustomDetailEvent extends StatelessWidget {
  const SliverAppBarCustomDetailEvent({
    super.key,
  });

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
                Assets.images.images.landscape2.image(fit: BoxFit.cover),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.8),
                  ),
                ),
              ],
            ),
          ),
          const FlexibleSpaceBar(
            background: BackgroundWidget(),
          ),
        ],
      ),
    );
  }
}
