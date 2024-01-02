import 'package:flutter/material.dart';
import 'package:myapp/src/theme/colors.dart';

class DescriptionEvent extends StatelessWidget {
  const DescriptionEvent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "About this event",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.black,
            ),
          ),
          SizedBox(height: 10),
          Text(
            'Introducing the latest board game, "Quest of Realms"! Embark on an epic journey through mystical lands, '
            'facing challenges and forging alliances. Unleash strategic prowess to conquer realms and emerge as the ultimate'
            ' champion. With captivating artwork and innovative gameplay, "Quest of Realms" promises an immersive adventure '
            'for players of all ages. Get ready to roll the dice and experience the thrill of this enchanting board game that'
            ' blends strategy and fantasy in a unique way!',
            style: TextStyle(
              fontSize: 15,
              color: AppColors.grey,
            ),
          )
        ],
      ),
    );
  }
}
