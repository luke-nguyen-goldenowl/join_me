import 'package:flutter/material.dart';
import 'package:myapp/src/features/detail_event/widget/background_widget.dart';
import 'package:myapp/src/theme/colors.dart';
import 'package:myapp/widgets/image/image_network.dart';

class SliverAppBarCustomDetailEvent extends StatelessWidget {
  const SliverAppBarCustomDetailEvent({
    super.key,
    this.actions,
    required this.images,
    required this.setIndexPageImage,
    required this.indexPageImage,
    required this.controller,
    this.leading,
  });

  final List<String> images;
  final Function(int index) setIndexPageImage;
  final int indexPageImage;
  final PageController controller;
  final List<Widget>? actions;
  final Widget? leading;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      leading: leading,
      foregroundColor: AppColors.white,
      expandedHeight: 200,
      actions: actions,
      flexibleSpace: Stack(
        children: <Widget>[
          Positioned.fill(
            child: Stack(
              fit: StackFit.expand,
              children: [
                XImageNetwork(
                  images.isNotEmpty ? images[indexPageImage] : null,
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
              setIndexPageImage: setIndexPageImage,
              indexPageImage: indexPageImage,
              controller: controller,
            ),
          ),
        ],
      ),
    );
  }
}
