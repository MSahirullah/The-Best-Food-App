import 'package:flutter/cupertino.dart';
import 'package:food_delivery_app/utils/dimentions.dart';

class SmallText extends StatelessWidget {
  SmallText({
    Key? key,
    this.color = const Color(0xFFccc7c5),
    required this.text,
    this.size = 0,
    this.height = 1.2,
    this.overFlow = TextOverflow.visible,
  }) : super(key: key);

  Color? color;
  final String text;
  double size;
  double height;
  TextOverflow overFlow;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: overFlow,
      style: TextStyle(
        color: color,
        fontFamily: 'Roboto',
        fontSize: size == 0 ? Dimentions.font12 : size,
        height: height,
      ),
    );
  }
}
