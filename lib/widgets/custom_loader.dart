import 'package:flutter/material.dart';
import 'package:food_delivery_app/utils/colors.dart';
import 'package:food_delivery_app/utils/dimentions.dart';

class CustomLoader extends StatelessWidget {
  const CustomLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: Dimentions.height20 * 5,
        width: Dimentions.width20 * 5,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Dimentions.radius20 * 5 / 2),
            color: AppColors.mainColor),
        alignment: Alignment.center,
        child: const CircularProgressIndicator(
          color: Colors.white,
        ),
      ),
    );
  }
}
