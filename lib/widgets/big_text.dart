import 'package:flutter/cupertino.dart';
import 'package:food_delivery_app/utils/dimentions.dart';

class BigText extends StatelessWidget {
  BigText(
      {Key? key,
      this.color = const Color(0xFF332d2b), 
      required this.text,
      this.overFlow = TextOverflow.ellipsis,
      this.size = 0})
      : super(key: key);

  Color? color;
  final String text;
  double size;
  TextOverflow overFlow;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: overFlow,
      maxLines: 1,
      style: TextStyle(
        color: color,
        fontWeight: FontWeight.w500,
        fontFamily: 'Roboto',
        fontSize: size == 0 ? Dimentions.font20 : size,
      ),
    );
  }
}
