import 'dart:math';

import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:food_delivery_app/controller/popular_product_controller.dart';
import 'package:food_delivery_app/controller/recommended_product_controller.dart';
import 'package:food_delivery_app/models/product_model.dart';
import 'package:food_delivery_app/pages/food/popular_food_detail.dart';
import 'package:food_delivery_app/routes/route_helper.dart';
import 'package:food_delivery_app/utils/app_constants.dart';
import 'package:food_delivery_app/utils/colors.dart';
import 'package:food_delivery_app/utils/dimentions.dart';
import 'package:food_delivery_app/widgets/app_column.dart';
import 'package:food_delivery_app/widgets/big_text.dart';
import 'package:food_delivery_app/widgets/icon_and_text.dart';
import 'package:food_delivery_app/widgets/small_text.dart';
import 'package:get/get.dart';

class FoodBodyPage extends StatefulWidget {
  const FoodBodyPage({Key? key}) : super(key: key);

  @override
  State<FoodBodyPage> createState() => _FoodBodyPageState();
}

class _FoodBodyPageState extends State<FoodBodyPage> {
  PageController pageController = PageController(viewportFraction: 0.85);

  var _currentPageValue = 0.0;
  double _scaleFactor = 0.8;
  double _height = Dimentions.pageViewContainer;

  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      setState(() {
        _currentPageValue = pageController.page!;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //Slider Section
        GetBuilder<PopularProductController>(builder: (popularProducts) {
          return popularProducts.isLoaded
              ? Container(
                  height: Dimentions.pageView,
                  child: PageView.builder(
                      controller: pageController,
                      itemCount: popularProducts.popularProductList.length,
                      itemBuilder: (context, position) {
                        return _buildPageItem(position,
                            popularProducts.popularProductList[position]);
                      }),
                )
              : CircularProgressIndicator(
                  color: AppColors.mainColor,
                );
        }),
        //Dot Indicator
        GetBuilder<PopularProductController>(builder: (popularProducts) {
          return DotsIndicator(
            dotsCount: popularProducts.popularProductList.isEmpty
                ? 1
                : popularProducts.popularProductList.length,
            position: _currentPageValue,
            decorator: DotsDecorator(
              activeColor: AppColors.mainColor,
              size: const Size.square(9.0),
              activeSize: const Size(18.0, 9.0),
              activeShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(Dimentions.radius5)),
            ),
          );
        }),
        //Popular Food
        SizedBox(height: Dimentions.height30),
        Container(
          margin: EdgeInsets.symmetric(horizontal: Dimentions.width30),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              BigText(text: "Recommended"),
              SizedBox(width: Dimentions.width10),
              Container(
                  margin: const EdgeInsets.only(bottom: 3),
                  child: BigText(text: ".", color: Colors.black26)),
              SizedBox(width: Dimentions.width10),
              Container(
                margin: const EdgeInsets.only(bottom: 2),
                child: SmallText(text: "Food Pairing"),
              ),
            ],
          ),
        ),
        //List of food and image
        //Recommended Food
        GetBuilder<RecommendedProductController>(builder: (recommendedProduct) {
          return recommendedProduct.isLoaded
              ? ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: recommendedProduct.recommendedProductList.length,
                  padding: EdgeInsets.only(
                      top: Dimentions.height20, bottom: Dimentions.height10),
                  itemBuilder: (contex, index) {
                    return GestureDetector(
                      onTap: () {
                        Get.toNamed(
                            RouteHelper.getRecommendedFood(index, 'homePage'));
                      },
                      child: Container(
                        margin: EdgeInsets.only(
                            left: Dimentions.width20,
                            right: Dimentions.width20,
                            top: Dimentions.height10),
                        child: Row(
                          children: [
                            // Image
                            Container(
                              width: Dimentions.listViewImgSize,
                              height: Dimentions.listViewImgSize,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(Dimentions.radius15),
                                color: Colors.white38,
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                      AppConstants.UPLOADS_IMG_URL +
                                          recommendedProduct
                                              .recommendedProductList[index]
                                              .img!),
                                ),
                              ),
                            ),
                            // Text
                            Expanded(
                              child: Container(
                                height: Dimentions.listViewTextContainer,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topRight:
                                        Radius.circular(Dimentions.radius20),
                                    bottomRight:
                                        Radius.circular(Dimentions.radius20),
                                  ),
                                  color: Colors.white,
                                ),
                                child: Padding(
                                  padding: EdgeInsets.only(
                                    left: Dimentions.width10,
                                    right: Dimentions.width10,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      BigText(
                                        text: recommendedProduct
                                            .recommendedProductList[index]
                                            .name!,
                                        size: Dimentions.font18,
                                      ),
                                      SizedBox(
                                        height: Dimentions.height10,
                                      ),
                                      SmallText(
                                          overFlow: TextOverflow.ellipsis,
                                          text: recommendedProduct
                                              .recommendedProductList[index]
                                              .description!),
                                      SizedBox(
                                        height: Dimentions.height10,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          IconAndText(
                                            icon: Icons.circle_sharp,
                                            text: "Normal",
                                            iconColor: AppColors.iconColor1,
                                          ),
                                          IconAndText(
                                              icon: Icons.location_on,
                                              text: "1.7km",
                                              iconColor: AppColors.mainColor),
                                          IconAndText(
                                            icon: Icons.access_time_rounded,
                                            text: "32 mins",
                                            iconColor: AppColors.iconColor2,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                )
              : CircularProgressIndicator(
                  color: AppColors.mainColor,
                );
        }),
        SizedBox(height: Dimentions.height20),
      ],
    );
  }

  Widget _buildPageItem(int index, ProductModel popularProduct) {
    Matrix4 matrix4 = Matrix4.identity();

    if (index == _currentPageValue.floor()) {
      var currScale = 1 - (_currentPageValue - index) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix4 = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
      //
    } else if (index == _currentPageValue.floor() + 1) {
      var currScale =
          _scaleFactor + (_currentPageValue - index + 1) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix4 = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
      //
    } else if (index == _currentPageValue.floor() - 1) {
      var currScale = 1 - (_currentPageValue - index) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix4 = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
      //
    } else {
      var currScale = 0.8;
      matrix4 = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, _height * (1 - _scaleFactor) / 2, 1);
      //
    }

    return Transform(
      transform: matrix4,
      child: Stack(
        children: [
          GestureDetector(
            onTap: () {
              Get.toNamed(RouteHelper.getPopularFood(index, "homePage"));
            },
            child: Container(
              height: Dimentions.pageViewContainer,
              margin: EdgeInsets.only(
                  left: Dimentions.width10, right: Dimentions.width10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimentions.radius25),
                color: index.isEven ? Color(0XFF69c5df) : Color(0xFF9294cc),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                      AppConstants.UPLOADS_IMG_URL + popularProduct.img!),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: Dimentions.pageViewTextContainer,
              margin: EdgeInsets.only(
                  left: Dimentions.width30,
                  right: Dimentions.width30,
                  bottom: Dimentions.height30),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimentions.radius20),
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0xFFe8e8e8),
                      blurRadius: 5.0,
                      offset: Offset(0, 5),
                    ),
                    BoxShadow(
                      color: Colors.white,
                      offset: Offset(-5, 0),
                    ),
                    BoxShadow(
                      color: Colors.white,
                      offset: Offset(5, 0),
                    )
                  ]),
              child: Container(
                padding: EdgeInsets.only(
                    top: Dimentions.height15,
                    left: Dimentions.width15,
                    right: Dimentions.width15),
                child: AppColumn(
                  text: popularProduct.name!,
                  stars: popularProduct.stars!,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
