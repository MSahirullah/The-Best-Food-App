import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:food_delivery_app/pages/auth/sign_up.dart';
import 'package:food_delivery_app/utils/colors.dart';
import 'package:food_delivery_app/utils/dimentions.dart';
import 'package:food_delivery_app/widgets/big_text.dart';
import 'package:food_delivery_app/widgets/text_field_widget.dart';
import 'package:get/get.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var passwordController = TextEditingController();
    var phoneController = TextEditingController();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: Dimentions.height20 * 2.5,
            ),
            Container(
              child: Center(
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  backgroundImage: AssetImage("assets/images/logo1.png"),
                  radius: 75,
                ),
              ),
            ),
            SizedBox(
              height: Dimentions.height20 * 2,
            ),
            Container(
              margin: EdgeInsets.only(left: Dimentions.width20),
              width: double.maxFinite,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Hello",
                    style: TextStyle(
                        fontSize: Dimentions.font20 * 3,
                        fontWeight: FontWeight.bold),
                  ),
                  RichText(
                    text: TextSpan(
                        text: "Sign into your account",
                        style: TextStyle(
                            color: Colors.grey[500],
                            fontSize: Dimentions.font18)),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: Dimentions.height20,
            ),

//phone
            TextFieldWidget(
              controller: phoneController,
              hintText: "Phone",
              icon: Icons.phone,
            ),
            SizedBox(
              height: Dimentions.height20,
            ),
            //password
            TextFieldWidget(
                controller: passwordController,
                hintText: "Password",
                icon: Icons.password_sharp),
            SizedBox(
              height: Dimentions.height25,
            ),
            Container(
              margin: EdgeInsets.only(right: Dimentions.width20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  RichText(
                    text: TextSpan(
                      text: "Sign into your account",
                      style: TextStyle(
                          color: Colors.grey[500], fontSize: Dimentions.font18),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: Dimentions.height20 * 2,
            ),
            Container(
              width: Dimentions.screenWidth / 2,
              height: Dimentions.height20 * 2.5,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimentions.radius25),
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
            SizedBox(
              height: Dimentions.height20 * 3,
            ),
            RichText(
              text: TextSpan(
                  text: "Don\'t have an account? ",
                  style: TextStyle(
                    color: Colors.grey[500],
                    fontSize: Dimentions.font16,
                  ),
                  children: [
                    TextSpan(
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => Get.to(() => SignUpPage(), transition: Transition.fade),
                      text: "Create",
                      style: TextStyle(
                          color: Colors.black87,
                          fontSize: Dimentions.font16,
                          fontWeight: FontWeight.w600),
                    ),
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}
