import 'package:flutter/material.dart';
import 'package:food_delivery_app/controller/auth_controller.dart';
import 'package:food_delivery_app/controller/location_controller.dart';
import 'package:food_delivery_app/controller/user_controller.dart';
import 'package:food_delivery_app/models/address_model.dart';
import 'package:food_delivery_app/routes/route_helper.dart';
import 'package:food_delivery_app/utils/colors.dart';
import 'package:food_delivery_app/utils/dimentions.dart';
import 'package:food_delivery_app/widgets/big_text.dart';
import 'package:food_delivery_app/widgets/text_field_widget.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AddAddressPage extends StatefulWidget {
  const AddAddressPage({Key? key}) : super(key: key);

  @override
  State<AddAddressPage> createState() => _AddAddressPageState();
}

class _AddAddressPageState extends State<AddAddressPage> {
  TextEditingController addressController = TextEditingController();
  TextEditingController contactPersonName = TextEditingController();
  TextEditingController contactPersonNumber = TextEditingController();

  late bool _isLogged;

  CameraPosition _cameraPosition =
      const CameraPosition(target: LatLng(7.2479, 80.4681), zoom: 17);
  LatLng _initializePosition = const LatLng(7.2479, 80.4681);

  @override
  void initState() {
    super.initState();

    _isLogged = Get.find<AuthController>().userLoggedIn();
    if (_isLogged && Get.find<UserController>().userModel == null) {
      Get.find<UserController>().getUserInfo();
    }
    if (Get.find<LocationController>().addressList.isNotEmpty) {
      Get.find<LocationController>().getAddressList();
      _cameraPosition = CameraPosition(
        target: LatLng(
          double.parse(Get.find<LocationController>().getAddress["latitude"]),
          double.parse(Get.find<LocationController>().getAddress["logtitude"]),
        ),
      );
      _initializePosition = LatLng(
        double.parse(Get.find<LocationController>().getAddress["latitude"]),
        double.parse(Get.find<LocationController>().getAddress["logtitude"]),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.mainColor,
        title: const Text("Address Page"),
      ),
      body: GetBuilder<UserController>(builder: (userController) {
        if (userController.userModel != null &&
            contactPersonName.text.isEmpty) {
          contactPersonName.text = userController.userModel.name;
          contactPersonNumber.text = userController.userModel.phone;

          if (Get.find<LocationController>().addressList.isNotEmpty) {
            addressController.text =
                Get.find<LocationController>().getUserAddress().address;
          }
        }

        return GetBuilder<LocationController>(builder: (locationController) {
          addressController.text = "${locationController.placeMark.name ?? ''}"
              "${locationController.placeMark.locality ?? ''}"
              "${locationController.placeMark.postalCode ?? ''}"
              "${locationController.placeMark.country ?? ''}";

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: Dimentions.height15 * 13,
                  width: Dimentions.screenWidth,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(Dimentions.radius15 / 2),
                      bottomRight: Radius.circular(Dimentions.radius15 / 2),
                    ),
                  ),
                  child: Stack(
                    children: [
                      GoogleMap(
                        initialCameraPosition: CameraPosition(
                          target: _initializePosition,
                          zoom: 17,
                        ),
                        zoomControlsEnabled: false,
                        compassEnabled: false,
                        indoorViewEnabled: true,
                        mapToolbarEnabled: false,
                        myLocationEnabled: true,
                        onCameraIdle: () {
                          locationController.updatePosition(
                              _cameraPosition, true);
                        },
                        onCameraMove: ((position) =>
                            _cameraPosition = position),
                        onMapCreated: ((controller) {
                          locationController.setMapController(controller);
                        }),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: Dimentions.height15),
                  child: SizedBox(
                    height: Dimentions.height25 * 2,
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: locationController.addressTypeList.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            locationController.setAddressTypeIndex(index);
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: Dimentions.width20,
                                vertical: Dimentions.height10),
                            margin: EdgeInsets.only(left: Dimentions.width20),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                  Dimentions.radius20 / 4,
                                ),
                                color: Theme.of(context).cardColor,
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey[200]!,
                                      spreadRadius: 1,
                                      blurRadius: 3),
                                ]),
                            child: Icon(
                              index == 0
                                  ? Icons.home_filled
                                  : index == 1
                                      ? Icons.work
                                      : Icons.location_on,
                              color:
                                  locationController.addressTypeIndex == index
                                      ? AppColors.mainColor
                                      : Theme.of(context).disabledColor,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                SizedBox(height: Dimentions.height20 * 1.3),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: Dimentions.width20),
                  child: BigText(
                    text: "Delivery Address",
                    size: Dimentions.font15,
                  ),
                ),
                SizedBox(height: Dimentions.height15),
                TextFieldWidget(
                  controller: addressController,
                  hintText: 'Your address',
                  icon: Icons.map,
                ),
                SizedBox(height: Dimentions.height20 * 1.3),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: Dimentions.width20),
                  child: BigText(
                    text: "Contact Name",
                    size: Dimentions.font15,
                  ),
                ),
                SizedBox(height: Dimentions.height15),
                TextFieldWidget(
                  controller: contactPersonName,
                  hintText: 'Your name',
                  icon: Icons.person,
                ),
                SizedBox(height: Dimentions.height20 * 1.3),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: Dimentions.width20),
                  child: BigText(
                    text: "Contact Number",
                    size: Dimentions.font15,
                  ),
                ),
                SizedBox(height: Dimentions.height15),
                TextFieldWidget(
                  controller: contactPersonNumber,
                  hintText: 'Your phone',
                  icon: Icons.phone,
                )
              ],
            ),
          );
        });
      }),
      bottomNavigationBar: GetBuilder<LocationController>(
        builder: ((locationController) {
          return Container(
            padding: EdgeInsets.symmetric(
              vertical: Dimentions.height20,
              horizontal: Dimentions.width20,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(Dimentions.radius20),
                topRight: Radius.circular(Dimentions.radius20),
              ),
              color: AppColors.buttonBackgroundColor,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    AddressModel addressModel = AddressModel(
                      addressType: locationController
                          .addressTypeList[locationController.addressTypeIndex],
                      contactPersonName: contactPersonName.text,
                      contactPersonNumber: contactPersonNumber.text,
                      address: addressController.text,
                      latitude: locationController.postion.latitude.toString(),
                      logtitude:
                          locationController.postion.longitude.toString(),
                    );
                    locationController
                        .addAddress(addressModel)
                        .then((response) {
                      if (response.isSuccess) {
                        Get.toNamed(RouteHelper.getInitial());
                        Get.snackbar("Address", "Added Successfully");
                      } else {
                        Get.snackbar("Address", "Couldn't save address");
                      }
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      vertical: Dimentions.height15,
                      horizontal: Dimentions.width20,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimentions.radius20),
                      color: AppColors.mainColor,
                    ),
                    child: BigText(
                      text: "Save Address",
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
