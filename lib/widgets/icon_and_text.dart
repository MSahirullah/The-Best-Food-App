import 'package:flutter/cupertino.dart';
import 'package:food_delivery_app/utils/dimentions.dart';
import 'package:food_delivery_app/widgets/small_text.dart';

class IconAndText extends StatelessWidget {
  const IconAndText(
      {Key? key,
      required this.icon,
      required this.text,
      required this.iconColor})
      : super(key: key);

  final IconData icon;
  final String text;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: iconColor,
          size: Dimentions.font18,
        ),
        SizedBox(
          width: Dimentions.width5,
        ),
        SmallText(
          text: text,
          size: Dimentions.font12,
        )
      ],
    );
  }
}
