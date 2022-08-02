import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:food_delivery_app/utils/colors.dart';
import 'package:food_delivery_app/utils/dimentions.dart';
import 'package:food_delivery_app/widgets/account_widget.dart';
import 'package:food_delivery_app/widgets/app_icon.dart';
import 'package:food_delivery_app/widgets/big_text.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        centerTitle: true,
        title: BigText(
          text: "Profile",
          size: Dimentions.font20,
          color: Colors.white,
        ),
      ),
      body: Container(
        width: double.maxFinite,
        margin: EdgeInsets.only(
          top: Dimentions.height20,
        ),
        child: Column(
          children: [
            //profile icon
            AppIcon(
              icon: Icons.person,
              backgroundColor: AppColors.mainColor,
              iconColor: Colors.white,
              iconSize: Dimentions.height25 * 3,
              size: Dimentions.height25 * 6,
            ),
            SizedBox(height: Dimentions.height30),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    //name
                    AccountWidget(
                      appIcon: AppIcon(
                        icon: Icons.person,
                        backgroundColor: AppColors.mainColor,
                        iconColor: Colors.white,
                        iconSize: Dimentions.height25,
                        size: Dimentions.height25 * 2,
                      ),
                      bigText: BigText(
                        text: "Mohamed Sahirullah",
                      ),
                    ),
                    SizedBox(height: Dimentions.height20),
                    //phone
                    AccountWidget(
                      appIcon: AppIcon(
                        icon: Icons.phone,
                        backgroundColor: AppColors.yellowColor,
                        iconColor: Colors.white,
                        iconSize: Dimentions.height25,
                        size: Dimentions.height25 * 2,
                      ),
                      bigText: BigText(
                        text: "+94 77 2 155 122",
                      ),
                    ),
                    SizedBox(height: Dimentions.height20),
                    //email
                    AccountWidget(
                      appIcon: AppIcon(
                        icon: Icons.email,
                        backgroundColor: AppColors.yellowColor,
                        iconColor: Colors.white,
                        iconSize: Dimentions.height25,
                        size: Dimentions.height25 * 2,
                      ),
                      bigText: BigText(
                        text: "msahirullah@gmail.com",
                      ),
                    ),
                    SizedBox(height: Dimentions.height20),
                    //address
                    AccountWidget(
                      appIcon: AppIcon(
                        icon: Icons.location_on,
                        backgroundColor: AppColors.yellowColor,
                        iconColor: Colors.white,
                        iconSize: Dimentions.height25,
                        size: Dimentions.height25 * 2,
                      ),
                      bigText: BigText(
                        text: "B/12, Owatta, Hingula",
                      ),
                    ),
                    SizedBox(height: Dimentions.height20),
                    //message
                    AccountWidget(
                      appIcon: AppIcon(
                        icon: Icons.message,
                        backgroundColor: Colors.redAccent,
                        iconColor: Colors.white,
                        iconSize: Dimentions.height25,
                        size: Dimentions.height25 * 2,
                      ),
                      bigText: BigText(
                        text: "Messages",
                      ),
                    ),

                    SizedBox(height: Dimentions.height20),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
