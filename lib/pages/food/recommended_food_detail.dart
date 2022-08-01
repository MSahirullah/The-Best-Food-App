import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:food_delivery_app/controller/cart_controller.dart';
import 'package:food_delivery_app/controller/popular_product_controller.dart';
import 'package:food_delivery_app/controller/recommended_product_controller.dart';
import 'package:food_delivery_app/pages/cart/cart_page.dart';
import 'package:food_delivery_app/routes/route_helper.dart';
import 'package:food_delivery_app/utils/app_constants.dart';
import 'package:food_delivery_app/utils/colors.dart';
import 'package:food_delivery_app/utils/dimentions.dart';
import 'package:food_delivery_app/widgets/app_icon.dart';
import 'package:food_delivery_app/widgets/big_text.dart';
import 'package:food_delivery_app/widgets/expandable_text.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';

class RecommendedFoodDetail extends StatelessWidget {
  const RecommendedFoodDetail(
      {Key? key, required this.pageId, required this.page})
      : super(key: key);

  final int pageId;
  final String page;

  @override
  Widget build(BuildContext context) {
    var product =
        Get.find<RecommendedProductController>().recommendedProductList[pageId];
    Get.find<PopularProductController>()
        .initProduct(product, Get.find<CartController>());

    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          //
          SliverAppBar(
            automaticallyImplyLeading: false,
            title: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (page == 'cartPage') {
                          Get.toNamed(RouteHelper.getCartPage());
                        } else {
                          Get.toNamed(RouteHelper.getInitial());
                        }
                      },
                      child: AppIcon(
                        icon: Icons.clear,
                      ),
                    ),
                    // AppIcon(
                    //   icon: Icons.add_shopping_cart_outlined,
                    // ),
                    GetBuilder<PopularProductController>(builder: (controller) {
                      return GestureDetector(
                        onTap: () {
                          if (controller.totalItems >= 1)
                            Get.toNamed(RouteHelper.getCartPage());
                        },
                        child: Stack(
                          children: [
                            AppIcon(icon: Icons.add_shopping_cart_outlined),
                            Get.find<PopularProductController>().totalItems >= 1
                                ? Positioned(
                                    right: 0,
                                    top: 0,
                                    child: AppIcon(
                                      icon: Icons.circle,
                                      size: 20,
                                      iconColor: Colors.transparent,
                                      backgroundColor: AppColors.mainColor,
                                    ),
                                  )
                                : Container(),
                            Get.find<PopularProductController>().totalItems >= 1
                                ? Positioned(
                                    right: Get.find<PopularProductController>()
                                                .totalItems >
                                            9
                                        ? 2
                                        : 5.5,
                                    top: 2,
                                    child: BigText(
                                      text: Get.find<PopularProductController>()
                                                  .totalItems <
                                              99
                                          ? Get.find<PopularProductController>()
                                              .totalItems
                                              .toString()
                                          : "99",
                                      size: Dimentions.font12,
                                      color: Colors.white,
                                    ),
                                  )
                                : Container(),
                          ],
                        ),
                      );
                    }),
                  ],
                ),
              ],
            ),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(35),
              child: Container(
                child: Center(
                  child: BigText(
                    text: product.name!,
                  ),
                ),
                width: double.maxFinite,
                padding: EdgeInsets.only(
                  top: 8,
                  bottom: 10,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(Dimentions.radius20),
                    topRight: Radius.circular(Dimentions.radius20),
                  ),
                ),
              ),
            ),
            pinned: true,
            backgroundColor: AppColors.yellowColor,
            expandedHeight: 300,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                AppConstants.UPLOADS_IMG_URL + product.img!,
                width: double.maxFinite,
                fit: BoxFit.cover,
              ),
            ),
          ),
          //
          SliverToBoxAdapter(
            child: Container(
              margin: EdgeInsets.only(
                  left: Dimentions.width20, right: Dimentions.width20),
              child: Column(children: [
                Container(
                  child: ExpandableText(
                    text: product.description!,
                  ),
                )
              ]),
            ),
          ),
        ],
      ),
      bottomNavigationBar: GetBuilder<PopularProductController>(
        builder: ((controller) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: Dimentions.width50,
                  vertical: Dimentions.height10,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        controller.setQuantity(false);
                      },
                      child: AppIcon(
                        icon: Icons.remove,
                        backgroundColor: AppColors.mainColor,
                        iconColor: Colors.white,
                        iconSize: Dimentions.font24,
                      ),
                    ),
                    BigText(
                      text:
                          "\$${product.price!}  X  ${controller.inCartItems.toString()}",
                      color: AppColors.mainBlackColor,
                      size: Dimentions.font24,
                    ),
                    GestureDetector(
                      onTap: () {
                        controller.setQuantity(true);
                      },
                      child: AppIcon(
                        icon: Icons.add,
                        backgroundColor: AppColors.mainColor,
                        iconColor: Colors.white,
                        iconSize: Dimentions.font24,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
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
                      child: Icon(
                        Icons.favorite,
                        color: AppColors.mainColor,
                        size: Dimentions.font26,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        controller.addItem(product);
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          vertical: Dimentions.height20,
                          horizontal: Dimentions.width20,
                        ),
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(Dimentions.radius20),
                          color: AppColors.mainColor,
                        ),
                        child: BigText(
                          text: "\$${product.price!} | Add to cart",
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
