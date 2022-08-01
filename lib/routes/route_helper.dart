import 'package:flutter/cupertino.dart';
import 'package:food_delivery_app/pages/cart/cart_page.dart';
import 'package:food_delivery_app/pages/food/popular_food_detail.dart';
import 'package:food_delivery_app/pages/food/recommended_food_detail.dart';
import 'package:food_delivery_app/pages/home/home_page.dart';
import 'package:food_delivery_app/pages/home/main_food_page.dart';
import 'package:food_delivery_app/pages/splash/splash_page.dart';
import 'package:get/get.dart';

class RouteHelper {
  //
  static const String splashPage = "/splash-page";
  static const String initial = "/";
  static const String popularFood = "/popular-food";
  static const String recommendedFood = "/recommended-food";
  static const String cartPage = "/cart-page";

  static String getSplashPage() => '$splashPage';
  static String getInitial() => '$initial';
  static String getPopularFood(int pageId, String page) =>
      '$popularFood?pageId=$pageId&page=$page';
  static String getRecommendedFood(int pageId, String page) =>
      '$recommendedFood?pageId=$pageId&page=$page';
  static String getCartPage() => '$cartPage';

  static List<GetPage> routes = [
    GetPage(
      name: splashPage,
      page: () => const SplashPage(),
    ),
    GetPage(
      name: initial,
      page: () => const HomePage(),
    ),
    GetPage(
      name: popularFood,
      transition: Transition.fadeIn,
      page: () {
        var pageId = Get.parameters['pageId'];
        var page = Get.parameters['page'];
        return PopularFoodDetail(pageId: int.parse(pageId!), page: page!);
      },
    ),
    GetPage(
      name: recommendedFood,
      transition: Transition.fadeIn,
      page: () {
        var pageId = Get.parameters['pageId'];
        var page = Get.parameters['page'];

        return RecommendedFoodDetail(pageId: int.parse(pageId!), page: page!);
      },
    ),
    GetPage(
      name: cartPage,
      page: () => const CartPage(),
      transition: Transition.fadeIn,
    ),
  ];
}
