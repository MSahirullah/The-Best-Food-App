import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:food_delivery_app/utils/colors.dart';
import 'package:food_delivery_app/utils/dimentions.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String buttonText;
  final bool transparent;
  final EdgeInsets? margin;
  final double? width;
  final double? height;
  final double? fontSize;
  final double? radius;
  final IconData? icon;

  const CustomButton({
    Key? key,
    this.onPressed,
    required this.buttonText,
    this.transparent = false,
    this.margin,
    this.width,
    this.height,
    this.fontSize,
    this.radius = 5,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ButtonStyle _flatButton = TextButton.styleFrom(
      backgroundColor: onPressed == null
          ? Theme.of(context).disabledColor
          : transparent
              ? Colors.transparent
              : AppColors.yellowColor,
      minimumSize: Size(
        width != null ? width! : Dimentions.screenWidth,
        height != null ? height! : Dimentions.height25 * 2,
      ),
      padding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius!),
      ),
    );

    return Center(
      child: SizedBox(
        width: width != null ? width! : Dimentions.screenWidth,
        height: height != null ? height! : Dimentions.height25 * 2,
        child: TextButton(
          onPressed: onPressed,
          style: _flatButton,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              icon != null
                  ? Padding(
                      padding: EdgeInsets.only(
                        right: Dimentions.width10 / 2,
                      ),
                      child: Icon(
                        icon,
                        color: transparent
                            ? AppColors.mainColor
                            : Theme.of(context).cardColor,
                      ),
                    )
                  : SizedBox(),
              Text(
                buttonText,
                style: TextStyle(
                  fontSize: fontSize != null ? fontSize : Dimentions.font16,
                  color: transparent
                      ? AppColors.mainColor
                      : Theme.of(context).cardColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
