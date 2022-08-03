import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/base/show_custom_snackbar.dart';
import 'package:food_delivery_app/controller/auth_controller.dart';
import 'package:food_delivery_app/models/signup_model.dart';
import 'package:food_delivery_app/routes/route_helper.dart';
import 'package:food_delivery_app/utils/colors.dart';
import 'package:food_delivery_app/utils/dimentions.dart';
import 'package:food_delivery_app/widgets/big_text.dart';
import 'package:food_delivery_app/widgets/custom_loader.dart';
import 'package:food_delivery_app/widgets/text_field_widget.dart';
import 'package:get/get.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var nameController = TextEditingController();
    var phoneController = TextEditingController();

    var signUpImages = [
      "t.png",
      "g.png",
      "f.png",
    ];

    void _registration(AuthController authController) {
      String email = emailController.text.trim();
      String phone = phoneController.text.trim();
      String name = nameController.text.trim();
      String password = passwordController.text.trim();

      if (name.isEmpty) {
        showCustomSnackBar("Type in a your name", title: "Name");
      } else if (phone.isEmpty) {
        showCustomSnackBar("Type in a your phone number",
            title: "Phone Number");
      } else if (email.isEmpty) {
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
        SignUpBody signUpBody = SignUpBody(
            name: name, email: email, phone: phone, password: password);
        authController.registration(signUpBody).then((status) {
          if (status.isSuccess) {
            Get.toNamed(RouteHelper.getInitial());
          } else {
            showCustomSnackBar(status.message);
          }
        });
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<AuthController>(builder: (authConroller) {
        return !authConroller.isLoading
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
                    //email
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
                      obscureText: true,
                    ),
                    SizedBox(
                      height: Dimentions.height20,
                    ),
                    //name
                    TextFieldWidget(
                      controller: nameController,
                      hintText: "Name",
                      icon: Icons.person,
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
                      height: Dimentions.height20 * 2,
                    ),
                    GestureDetector(
                      onTap: () {
                        _registration(authConroller);
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
                            text: "Sign Up",
                            size: Dimentions.font20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: Dimentions.height15,
                    ),
                    RichText(
                      text: TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => Get.to(Get.toNamed(RouteHelper.getSignInPage())),
                          text: "Have an account already?",
                          style: TextStyle(
                              color: Colors.grey[500],
                              fontSize: Dimentions.font16)),
                    ),
                    SizedBox(
                      height: Dimentions.height20,
                    ),
                    RichText(
                      text: TextSpan(
                          text: "Sign up using one of the follwoing methods",
                          style: TextStyle(
                              color: Colors.grey[500],
                              fontSize: Dimentions.font26 * 0.5)),
                    ),
                    SizedBox(
                      height: Dimentions.height10,
                    ),
                    Wrap(
                      children: List.generate(
                        3,
                        (index) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircleAvatar(
                            radius: Dimentions.radius25,
                            backgroundColor: Colors.white,
                            backgroundImage: AssetImage(
                                "assets/images/${signUpImages[index]}"),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )
            : const CustomLoader();
      }),
    );
  }
}
