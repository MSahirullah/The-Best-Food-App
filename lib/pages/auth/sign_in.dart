import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/base/show_custom_snackbar.dart';
import 'package:food_delivery_app/controller/auth_controller.dart';
import 'package:food_delivery_app/routes/route_helper.dart';
import 'package:food_delivery_app/utils/colors.dart';
import 'package:food_delivery_app/utils/dimentions.dart';
import 'package:food_delivery_app/widgets/big_text.dart';
import 'package:food_delivery_app/widgets/custom_loader.dart';
import 'package:food_delivery_app/widgets/text_field_widget.dart';
import 'package:get/get.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var passwordController = TextEditingController();
    var emailController = TextEditingController();

    void _login(AuthController authController) {
      String email = emailController.text.trim();
      String password = passwordController.text.trim();

      if (email.isEmpty) {
        showCustomSnackBar("Type in a your email address",
            title: "Email address");
      } else if (!GetUtils.isEmail(email)) {
        showCustomSnackBar("Type in a valid email address",
            title: "Email address");
      } else if (password.isEmpty) {
        showCustomSnackBar("Type in a your password", title: "Password");
      } else if (password.length < 6) {
        showCustomSnackBar("Password can not be less than siz characters",
            title: "Password");
      } else {
        authController.login(email, password).then((status) {
          if (status.isSuccess) {
            Get.toNamed(RouteHelper.getCartPage());
          } else {
            showCustomSnackBar(status.message);
          }
        });
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<AuthController>(builder: (authController) {
        return !authController.isLoading
            ? SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: Dimentions.height20 * 2.5,
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(RouteHelper.getInitial());
                      },
                      child: const Center(
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          backgroundImage:
                              AssetImage("assets/images/logo1.png"),
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
                      controller: emailController,
                      hintText: "Email",
                      icon: Icons.email,
                    ),
                    SizedBox(
                      height: Dimentions.height20,
                    ),
                    //password
                    TextFieldWidget(
                        controller: passwordController,
                        hintText: "Password",
                        icon: Icons.password_sharp,
                        obscureText: true),
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
                                  color: Colors.grey[500],
                                  fontSize: Dimentions.font18),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: Dimentions.height20 * 2,
                    ),
                    GestureDetector(
                      onTap: () {
                        _login(authController);
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
                      height: Dimentions.height20 * 3,
                    ),
                    RichText(
                      text: TextSpan(
                          text: "Don't have an account? ",
                          style: TextStyle(
                            color: Colors.grey[500],
                            fontSize: Dimentions.font16,
                          ),
                          children: [
                            TextSpan(
                              recognizer: TapGestureRecognizer()
                                ..onTap = () => Get.toNamed(RouteHelper.getSignUpPage()),
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
              )
            : const CustomLoader();
      }),
    );
  }
}
