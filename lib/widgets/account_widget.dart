import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:food_delivery_app/utils/dimentions.dart';
import 'package:food_delivery_app/widgets/app_icon.dart';
import 'package:food_delivery_app/widgets/big_text.dart';

class AccountWidget extends StatelessWidget {
  const AccountWidget({Key? key, required this.appIcon, required this.bigText})
      : super(key: key);

  final AppIcon appIcon;
  final BigText bigText;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: Dimentions.width20,
        top: Dimentions.height10,
        bottom: Dimentions.height10,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 1,
            offset: Offset(0, 2),
            color: Colors.grey.withOpacity(0.2),
          ),
        ],
      ),
      child: Row(
        children: [
          appIcon,
          SizedBox(
            width: Dimentions.width20,
          ),
          bigText,
        ],
      ),
    );
  }
}
