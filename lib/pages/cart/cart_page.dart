import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:food_delivery_app/controller/cart_controller.dart';
import 'package:food_delivery_app/controller/popular_product_controller.dart';
import 'package:food_delivery_app/controller/recommended_product_controller.dart';
import 'package:food_delivery_app/pages/home/main_food_page.dart';
import 'package:food_delivery_app/routes/route_helper.dart';
import 'package:food_delivery_app/utils/app_constants.dart';
import 'package:food_delivery_app/utils/colors.dart';
import 'package:food_delivery_app/utils/dimentions.dart';
import 'package:food_delivery_app/widgets/app_icon.dart';
import 'package:food_delivery_app/widgets/big_text.dart';
import 'package:food_delivery_app/widgets/small_text.dart';
import 'package:get/get.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: Dimentions.height30,
            left: Dimentions.width20,
            right: Dimentions.width20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Get.toNamed(RouteHelper.getInitial());
                  },
                  child: AppIcon(
                    icon: Icons.arrow_back_ios,
                    iconColor: Colors.white,
                    backgroundColor: AppColors.mainColor,
                  ),
                ),
                SizedBox(width: Dimentions.width20 * 5),
                GestureDetector(
                  onTap: () {
                    Get.toNamed(RouteHelper.getInitial());
                  },
                  child: AppIcon(
                    icon: Icons.home_outlined,
                    iconColor: Colors.white,
                    backgroundColor: AppColors.mainColor,
                    iconSize: Dimentions.font20,
                  ),
                ),
                AppIcon(
                  icon: Icons.shopping_cart,
                  iconColor: Colors.white,
                  backgroundColor: AppColors.mainColor,
                ),
              ],
            ),
          ),
          Positioned(
            top: Dimentions.height20 * 4,
            left: Dimentions.width20,
            right: Dimentions.width20,
            bottom: 0,
            child: Container(
              child: MediaQuery.removePadding(
                context: context,
                removeTop: true,
                child: GetBuilder<CartController>(builder: (cartController) {
                  var _cartList = cartController.getItems;

                  return ListView.builder(
                    itemCount: _cartList.length,
                    itemBuilder: (_, index) {
                      return Container(
                        height: Dimentions.height20 * 5,
                        width: double.maxFinite,
                        margin: EdgeInsets.only(bottom: Dimentions.height10),
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                var popularIndex =
                                    Get.find<PopularProductController>()
                                        .popularProductList
                                        .indexOf(_cartList[index].product!);

                                if (popularIndex >= 0) {
                                  Get.toNamed(RouteHelper.getPopularFood(
                                      popularIndex, "cartPage"));
                                } else {
                                  var recommendedIndex =
                                      Get.find<RecommendedProductController>()
                                          .recommendedProductList
                                          .indexOf(_cartList[index].product!);
                                  Get.toNamed(RouteHelper.getRecommendedFood(
                                      recommendedIndex, "cartPage"));
                                }
                              },
                              child: Container(
                                width: Dimentions.height20 * 5,
                                height: Dimentions.height20 * 5,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(
                                        AppConstants.UPLOADS_IMG_URL +
                                            _cartList[index].img!,
                                      ),
                                    ),
                                    borderRadius: BorderRadius.circular(
                                        Dimentions.radius15),
                                    color: Colors.white),
                              ),
                            ),
                            SizedBox(width: Dimentions.width10),
                            Expanded(
                              child: Container(
                                height: Dimentions.height20 * 5,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    BigText(
                                      text: _cartList[index].name!,
                                      color: Colors.black54,
                                    ),
                                    SmallText(text: "Spicy"),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        BigText(
                                          text: "\$ ${_cartList[index].price!}",
                                          color: Colors.redAccent,
                                        ),
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                            vertical: Dimentions.height10,
                                            horizontal: Dimentions.width10,
                                          ),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                Dimentions.radius20,
                                              ),
                                              color: Colors.white),
                                          child: Row(
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  cartController.addItem(
                                                      _cartList[index].product!,
                                                      -1);
                                                },
                                                child: Icon(
                                                  Icons.remove,
                                                  color: AppColors.signColor,
                                                ),
                                              ),
                                              SizedBox(
                                                  width: Dimentions.width10),
                                              BigText(
                                                  text: _cartList[index]
                                                      .quantity!
                                                      .toString()),
                                              SizedBox(
                                                  width: Dimentions.width10),
                                              GestureDetector(
                                                onTap: () {
                                                  cartController.addItem(
                                                      _cartList[index].product!,
                                                      1);
                                                },
                                                child: Icon(
                                                  Icons.add,
                                                  color: AppColors.signColor,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                }),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: GetBuilder<CartController>(
        builder: (cartController) {
          return Container(
            height: Dimentions.bottomHeightBar,
            padding: EdgeInsets.symmetric(
              vertical: Dimentions.height30,
              horizontal: Dimentions.width20,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(Dimentions.radius40),
                topRight: Radius.circular(Dimentions.radius40),
              ),
              color: AppColors.buttonBackgroundColor,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                    vertical: Dimentions.height20,
                    horizontal: Dimentions.width20,
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        Dimentions.radius20,
                      ),
                      color: Colors.white),
                  child: Row(
                    children: [
                      SizedBox(width: Dimentions.width10),
                      BigText(
                        text: "\$ ${cartController.totalAmount.toString()}",
                      )
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    cartController.addToHistory();
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      vertical: Dimentions.height20,
                      horizontal: Dimentions.width20,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimentions.radius20),
                      color: AppColors.mainColor,
                    ),
                    child: BigText(
                      text: "Check out",
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
