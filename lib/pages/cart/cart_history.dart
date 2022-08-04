import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:food_delivery_app/base/no_data_page.dart';
import 'package:food_delivery_app/controller/cart_controller.dart';
import 'package:food_delivery_app/models/cart_model.dart';
import 'package:food_delivery_app/routes/route_helper.dart';
import 'package:food_delivery_app/utils/app_constants.dart';
import 'package:food_delivery_app/utils/colors.dart';
import 'package:food_delivery_app/utils/dimentions.dart';
import 'package:food_delivery_app/widgets/app_icon.dart';
import 'package:food_delivery_app/widgets/big_text.dart';
import 'package:food_delivery_app/widgets/small_text.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CartHistory extends StatelessWidget {
  const CartHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //
    var getCartHistoryList =
        Get.find<CartController>().getCartHistoryList().reversed.toList();
    Map<String, int> cartItemsPerOrder = {};

    for (int i = 0; i < getCartHistoryList.length; i++) {
      if (cartItemsPerOrder.containsKey(getCartHistoryList[i].time)) {
        cartItemsPerOrder.update(
            getCartHistoryList[i].time!, (value) => ++value);
      } else {
        cartItemsPerOrder.putIfAbsent(getCartHistoryList[i].time!, () => 1);
      }
    }

    List<int> cartItemsPerOrderToList() {
      return cartItemsPerOrder.entries.map((e) => e.value).toList();
    }

    List<String> cartOrderTimeToList() {
      return cartItemsPerOrder.entries.map((e) => e.key).toList();
    }

    List<int> itemsPerOrder = cartItemsPerOrderToList();

    var listCounter = 0;

    Widget timeWidget(int index) {
      var outputDate = DateTime.now().toString();

      if (index < getCartHistoryList.length) {
        DateTime parseDate = DateFormat("yyyy-MM-dd HH:mm:ss")
            .parse(getCartHistoryList[listCounter].time!);
        var inputDate = DateTime.parse(parseDate.toString());
        var outputFormat = DateFormat("MM/dd/yyyy hh:mm a");

        outputDate = outputFormat.format(inputDate);
      }
      return BigText(text: outputDate);
    }

    return Scaffold(
      body: Column(
        children: [
          Container(
            height: Dimentions.height20 * 4,
            width: double.maxFinite,
            color: AppColors.mainColor,
            padding: EdgeInsets.only(top: Dimentions.height25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                BigText(
                  text: "Cart history",
                  color: Colors.white,
                ),
                GestureDetector(
                  onTap: () {
                    Get.toNamed(RouteHelper.getCartPage());
                  },
                  child: AppIcon(
                    icon: Icons.shopping_cart_outlined,
                    iconColor: AppColors.mainColor,
                    iconSize: Dimentions.font18,
                  ),
                ),
              ],
            ),
          ),
          GetBuilder<CartController>(builder: (cartController) {
            return cartController.getCartHistoryList().isNotEmpty
                ? Expanded(
                    child: Container(
                      margin: EdgeInsets.only(
                        top: Dimentions.height20,
                        left: Dimentions.width20,
                        right: Dimentions.width20,
                      ),
                      child: MediaQuery.removePadding(
                        removeTop: true,
                        context: context,
                        child: ListView(
                          children: [
                            for (int i = 0; i < itemsPerOrder.length; i++)
                              Container(
                                height: Dimentions.height20 * 6,
                                margin: EdgeInsets.only(
                                    bottom: Dimentions.height20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // (() {
                                    //   DateTime parseDate = DateFormat(
                                    //           "yyyy-MM-dd HH:mm:ss")
                                    //       .parse(getCartHistoryList[listCounter]
                                    //           .time!);
                                    //   var inputDate =
                                    //       DateTime.parse(parseDate.toString());
                                    //   var outputFormat =
                                    //       DateFormat("MM/dd/yyyy hh:mm a");
                                    //   var outputDate =
                                    //       outputFormat.format(inputDate);
                                    //   return BigText(text: outputDate);
                                    // }()),
                                    timeWidget(listCounter),
                                    SizedBox(
                                      height: Dimentions.height10,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Wrap(
                                          direction: Axis.horizontal,
                                          children: List.generate(
                                              itemsPerOrder[i], (index) {
                                            if (listCounter <
                                                getCartHistoryList.length) {
                                              listCounter++;
                                            }
                                            return index <= 2
                                                ? Container(
                                                    height:
                                                        Dimentions.height20 * 4,
                                                    width:
                                                        Dimentions.height20 * 4,
                                                    margin: EdgeInsets.only(
                                                        right:
                                                            Dimentions.width10 /
                                                                2),
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius
                                                          .circular(Dimentions
                                                                  .radius15 /
                                                              2),
                                                      image: DecorationImage(
                                                        fit: BoxFit.cover,
                                                        image: NetworkImage(AppConstants
                                                                .UPLOADS_IMG_URL +
                                                            getCartHistoryList[
                                                                    listCounter -
                                                                        1]
                                                                .img!),
                                                      ),
                                                    ),
                                                  )
                                                : Container();
                                          }),
                                        ),
                                        SizedBox(
                                          height: Dimentions.height20 * 4,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              SmallText(
                                                  text: "Total",
                                                  color: AppColors.titleColor),
                                              BigText(
                                                text:
                                                    "${itemsPerOrder[i]} Items",
                                                color: AppColors.titleColor,
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  var orderTime =
                                                      cartOrderTimeToList();
                                                  Map<int, CartModel>
                                                      moreOrder = {};

                                                  for (int j = 0;
                                                      j <
                                                          getCartHistoryList
                                                              .length;
                                                      j++) {
                                                    if (getCartHistoryList[j]
                                                            .time ==
                                                        orderTime[i]) {
                                                      moreOrder.putIfAbsent(
                                                          getCartHistoryList[j]
                                                              .id!,
                                                          () => CartModel.fromJson(
                                                              jsonDecode(jsonEncode(
                                                                  getCartHistoryList[
                                                                      j]))));
                                                    }
                                                  }
                                                  Get.find<CartController>()
                                                      .setItems = moreOrder;
                                                  Get.find<CartController>()
                                                      .addToCartList();
                                                  Get.toNamed(RouteHelper
                                                      .getCartPage());
                                                },
                                                child: Container(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal:
                                                          Dimentions.width10,
                                                      vertical:
                                                          Dimentions.height10 /
                                                              2),
                                                  decoration: BoxDecoration(
                                                      borderRadius: BorderRadius
                                                          .circular(Dimentions
                                                                  .radius15 /
                                                              2),
                                                      border: Border.all(
                                                          width: 1,
                                                          color: AppColors
                                                              .mainColor)),
                                                  child: SmallText(
                                                    text: "one more",
                                                  ),
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
                          ],
                        ),
                      ),
                    ),
                  )
                : SizedBox(
                    height: Dimentions.screenHeight / 1.5,
                    child: const Center(
                      child: NoDataPage(
                        text: "You didn't buy anything so far!",
                        imgPath: "assets/images/empty_box.png",
                      ),
                    ),
                  );
          }),
        ],
      ),
    );
  }
}
