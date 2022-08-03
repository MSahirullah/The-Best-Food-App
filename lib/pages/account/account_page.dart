import 'package:flutter/material.dart';
import 'package:food_delivery_app/controller/auth_controller.dart';
import 'package:food_delivery_app/controller/cart_controller.dart';
import 'package:food_delivery_app/controller/user_controller.dart';
import 'package:food_delivery_app/routes/route_helper.dart';
import 'package:food_delivery_app/utils/colors.dart';
import 'package:food_delivery_app/utils/dimentions.dart';
import 'package:food_delivery_app/widgets/account_widget.dart';
import 'package:food_delivery_app/widgets/app_icon.dart';
import 'package:food_delivery_app/widgets/big_text.dart';
import 'package:food_delivery_app/widgets/custom_loader.dart';
import 'package:get/get.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool userLoggedIn = Get.find<AuthController>().userLoggedIn();
    if (userLoggedIn) {
      Get.find<UserController>().getUserInfo();
    }

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
      body: GetBuilder<UserController>(builder: (userController) {
        return userLoggedIn
            ? (!userController.isLoading
                ? Container(
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
                                    text: userController.userModel.name,
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
                                    text: userController.userModel.phone,
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
                                    text: userController.userModel.email,
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
                                    text: "Locate your address",
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
                                //logout
                                GestureDetector(
                                  onTap: () {
                                    if (Get.find<AuthController>()
                                        .userLoggedIn()) {
                                      Get.find<AuthController>()
                                          .clearSharedData();
                                      Get.find<CartController>().clear();
                                      Get.find<CartController>()
                                          .clearCartHistory();
                                      Get.toNamed(RouteHelper.getSignInPage());
                                    }
                                  },
                                  child: AccountWidget(
                                    appIcon: AppIcon(
                                      icon: Icons.logout,
                                      backgroundColor: Colors.redAccent,
                                      iconColor: Colors.white,
                                      iconSize: Dimentions.height25,
                                      size: Dimentions.height25 * 2,
                                    ),
                                    bigText: BigText(
                                      text: "Logout",
                                    ),
                                  ),
                                ),

                                SizedBox(height: Dimentions.height20),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                : const CustomLoader())
            : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Image(
                      height: Dimentions.height20 * 12,
                      width: Dimentions.width20 * 12,
                      image: const AssetImage(
                        "assets/images/auth.png",
                      ),
                    ),
                  ),
                  SizedBox(
                    height: Dimentions.height20 * 3,
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(RouteHelper.getSignInPage());
                    },
                    child: Container(
                      width: Dimentions.screenWidth / 2,
                      height: Dimentions.height20 * 2.5,
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(Dimentions.radius25),
                        color: AppColors.mainColor,
                      ),
                      child: Center(
                        child: BigText(
                          text: "Sign In",
                          size: Dimentions.font20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: Dimentions.height20,
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(RouteHelper.getSignUpPage());
                    },
                    child: Container(
                      width: Dimentions.screenWidth / 2,
                      height: Dimentions.height20 * 2.5,
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(Dimentions.radius25),
                        color: AppColors.yellowColor,
                      ),
                      child: Center(
                        child: BigText(
                          text: "Sign Up",
                          size: Dimentions.font20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
      }),
    );
  }
}
