import 'package:flutter/material.dart';
import 'package:myapp/gen/assets.gen.dart';
import 'package:myapp/src/router/coordinator.dart';
import 'package:myapp/src/theme/colors.dart';

class Ticket extends StatelessWidget {
  const Ticket({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 170,
      padding: const EdgeInsets.all(5),
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 8),
            color: AppColors.black.withOpacity(0.1),
            blurRadius: 37,
            spreadRadius: 0,
          ),
        ],
      ),
      child: ClipPath(
        clipper: TicketClipper(),
        child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
          return InkWell(
            onTap: () {
              AppCoordinator.showEventDetails(id: '1');
            },
            child: Container(
              padding: const EdgeInsets.all(10),
              color: AppColors.white,
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: HeaderTicket(),
                  ),
                  SizedBox(height: 15),
                  Expanded(
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: BottomTicket(),
                    ),
                  )
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}

class BottomTicket extends StatelessWidget {
  const BottomTicket({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Date",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: AppColors.grey,
              ),
            ),
            Text(
              "December 21, 2023",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: AppColors.black,
              ),
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Time",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: AppColors.grey,
              ),
            ),
            Text(
              "8:00 AM",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: AppColors.black,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class HeaderTicket extends StatelessWidget {
  const HeaderTicket({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Assets.images.images.avatar.image(
            height: 60,
            width: 60,
          ),
        ),
        const SizedBox(width: 10),
        const SizedBox(
          width: 250,
          child: Text(
            "Let's play different festival",
            style: TextStyle(
              color: AppColors.black,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        )
      ],
    );
  }
}

class TicketClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    const double borderRadius = 20;
    const double clipRadius = 10;

    final clipCenterY = size.height * 0.5;

    path.addRRect(RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.width, size.height),
      const Radius.circular(borderRadius),
    ));

    final clipPath = Path();

    // circle on the left
    clipPath.addOval(Rect.fromCircle(
      center: Offset(0, clipCenterY),
      radius: clipRadius,
    ));

    // circle on the right
    clipPath.addOval(Rect.fromCircle(
      center: Offset(size.width, clipCenterY),
      radius: clipRadius,
    ));

    const dashWidth = 2.0;
    const dashSpace = 8.0;
    double startX = 10;

    while (startX < size.width - 5) {
      clipPath
          .addRect(Rect.fromLTWH(startX, clipCenterY, dashSpace, dashWidth));
      startX += 12;
    }

    final ticketPath = Path.combine(
      PathOperation.reverseDifference,
      clipPath,
      path,
    );

    return ticketPath;
  }

  @override
  bool shouldReclip(TicketClipper oldClipper) => true;
}
