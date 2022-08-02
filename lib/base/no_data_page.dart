import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:food_delivery_app/utils/dimentions.dart';
import 'package:food_delivery_app/widgets/small_text.dart';

class NoDataPage extends StatelessWidget {
  const NoDataPage(
      {Key? key,
      required this.text,
      this.imgPath = "assets/images/empty_cart.png"})
      : super(key: key);

  final String text;
  final String imgPath;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Image.asset(
          imgPath,
          height: Dimentions.height25 * 5,
          width: Dimentions.width25 * 5,
        ),
        SizedBox(
          height: Dimentions.height25,
        ),
        SmallText(
          text: text,
          size: Dimentions.font15,
          color: Theme.of(context).disabledColor,
          align: TextAlign.center,
        ),
      ],
    );
  }
}
