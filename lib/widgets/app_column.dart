import 'package:flutter/material.dart';
import 'package:food_delivery_app/utils/colors.dart';
import 'package:food_delivery_app/utils/dimentions.dart';
import 'package:food_delivery_app/widgets/big_text.dart';
import 'package:food_delivery_app/widgets/icon_and_text.dart';
import 'package:food_delivery_app/widgets/small_text.dart';

class AppColumn extends StatelessWidget {
  const AppColumn({Key? key, required this.text, required this.stars})
      : super(key: key);

  final String text;
  final int stars;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BigText(
          text: text,
          size: Dimentions.font20,
        ),
        SizedBox(height: Dimentions.height10),
        Row(
          children: [
            Wrap(
              children: List.generate(
                5,
                (index) => Icon(
                  Icons.star,
                  color:
                      index < stars ? AppColors.mainColor : AppColors.signColor,
                  size: Dimentions.font15,
                ),
                // (index) { return Icon(
                //   Icons.star,
                //   color: AppColors.mainColor,
                //   size: Dimentions.height15,
                // ),}
              ),
            ),
            SizedBox(width: Dimentions.width10),
            SmallText(text: "4.5"),
            SizedBox(width: Dimentions.width10),
            SmallText(text: "1287"),
            SizedBox(width: Dimentions.width10),
            SmallText(text: "comments"),
          ],
        ),
        SizedBox(height: Dimentions.height20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            IconAndText(
              icon: Icons.circle_sharp,
              text: "Normal",
              iconColor: AppColors.iconColor1,
            ),
            IconAndText(
                icon: Icons.location_on,
                text: "1.7km",
                iconColor: AppColors.mainColor),
            IconAndText(
              icon: Icons.access_time_rounded,
              text: "32 mins",
              iconColor: AppColors.iconColor2,
            ),
          ],
        ),
      ],
    );
  }
}
