import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/widgets/smalltext.dart';

import '../utils/colors.dart';
import '../utils/dimensions.dart';
import 'bigtext.dart';
import 'icons_and _text_widget.dart';

class AppColumn extends StatelessWidget {
  final String text;
  const AppColumn({Key? key , required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BigText(text: text, size: Dimensions.font26,),
        SizedBox(height: Dimensions.height10),
        Row(
          children: [
            Wrap(
              children: List.generate(
                5,
                    (index) => Icon(
                  Icons.star,
                  color: AppColors.mainColor,
                  size: 15,
                ),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            SmallText(text: "4.5"),
            SizedBox(
              width: 10,
            ),
            SmallText(text: "1287"),
            SizedBox(
              width: 10,
            ),
            SmallText(text: "Comments")
          ],
        ),
        SizedBox(
          height: Dimensions.height20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconsAndTextWidget(
              text: "Normal",
              icon: Icons.circle_sharp,
              iconColor: AppColors.iconColor1,
            ),
            IconsAndTextWidget(
              text: "1.7 Km",
              icon: Icons.location_on,
              iconColor: AppColors.mainColor,
            ),
            IconsAndTextWidget(
              text: "32 Min",
              icon: Icons.access_time_rounded,
              iconColor: AppColors.iconColor2,
            )
          ],
        )
      ],
    );
  }
}
