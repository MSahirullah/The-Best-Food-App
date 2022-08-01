import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:food_delivery_app/controller/popular_product_controller.dart';
import 'package:food_delivery_app/controller/recommended_product_controller.dart';
import 'package:food_delivery_app/routes/route_helper.dart';
import 'package:food_delivery_app/utils/dimentions.dart';
import 'package:get/get.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController _controller;

 Future<void> _loadResources() async {
    await Get.find<PopularProductController>().getPopularProductList();
    await Get.find<RecommendedProductController>().getRecommendedProductList();    
  }

  @override
  void initState() {
    super.initState();
    _loadResources();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..forward();

    animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.linear,
    );
    Timer(const Duration(seconds: 3),
        () => Get.offNamed(RouteHelper.getInitial()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ScaleTransition(
            scale: animation,
            child: Center(
              child: Image.asset(
                "assets/images/logo1.png",
                width: Dimentions.height20 * 10,
              ),
            ),
          ),
          SizedBox(
            height: Dimentions.height15,
          ),
          Center(
            child: Image.asset(
              "assets/images/logo2.png",
              width: Dimentions.height20 * 10,
            ),
          ),
        ],
      ),
    );
  }
}
