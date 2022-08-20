import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:food_delivery_app/controller/location_controller.dart';
import 'package:food_delivery_app/routes/route_helper.dart';
import 'package:food_delivery_app/utils/colors.dart';
import 'package:food_delivery_app/utils/dimentions.dart';
import 'package:food_delivery_app/widgets/cutom_button.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PickAddressMap extends StatefulWidget {
  const PickAddressMap({
    Key? key,
    required this.fromSignUp,
    required this.fromAddress,
    required this.googleMapController,
  }) : super(key: key);

  final bool fromSignUp;
  final bool fromAddress;
  final GoogleMapController googleMapController;

  @override
  State<PickAddressMap> createState() => _PickAddressMapState();
}

class _PickAddressMapState extends State<PickAddressMap> {
  late LatLng _initialPosition;
  late GoogleMapController _mapController;
  late CameraPosition _cameraPosition;

  @override
  void initState() {
    super.initState();

    if (Get.find<LocationController>().addressList.isEmpty) {
      // print(Get.find<LocationController>().postion);
      if (Get.find<LocationController>().postion.latitude != 0 &&
          Get.find<LocationController>().postion.longitude != 0) {
        _initialPosition = LatLng(
            Get.find<LocationController>().postion.latitude,
            Get.find<LocationController>().postion.longitude);
        _cameraPosition = CameraPosition(target: _initialPosition, zoom: 17);
      } else {
        _initialPosition = const LatLng(7.2479, 80.4681);
        _cameraPosition = CameraPosition(target: _initialPosition, zoom: 17);
      }
    } else {
      if (Get.find<LocationController>().addressList.isNotEmpty) {
        _initialPosition = LatLng(
          double.parse(Get.find<LocationController>().getAddress["latitude"]),
          double.parse(
            Get.find<LocationController>().getAddress["longitude"],
          ),
        );
        _cameraPosition = CameraPosition(target: _initialPosition, zoom: 17);
      }
      //remove
      else {
        _initialPosition = const LatLng(7.2479, 80.4681);
        _cameraPosition = CameraPosition(target: _initialPosition, zoom: 17);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LocationController>(builder: (locationController) {
      return Scaffold(
        body: SafeArea(
          child: Center(
            child: SizedBox(
              width: double.maxFinite,
              child: Stack(
                children: [
                  GoogleMap(
                    zoomControlsEnabled: false,
                    onCameraMove: (position) {
                      _cameraPosition = position;
                    },
                    onCameraIdle: () {
                      locationController.updatePosition(_cameraPosition, false);
                    },
                    initialCameraPosition: CameraPosition(
                      target: _initialPosition,
                      zoom: 17,
                    ),
                  ),
                  Center(
                    child: !locationController.loading
                        ? Image.asset(
                            "assets/images/pick_mark.png",
                            height: Dimentions.height25 * 2,
                            width: Dimentions.width25 * 2,
                          )
                        : const CircularProgressIndicator(),
                  ),
                  Positioned(
                    top: Dimentions.height30,
                    left: Dimentions.width20,
                    right: Dimentions.width20,
                    child: InkWell(
                      onTap: () {
                        
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: Dimentions.width10,
                        ),
                        height: Dimentions.height25 * 2,
                        decoration: BoxDecoration(
                          color: AppColors.mainColor,
                          borderRadius: BorderRadius.circular(
                            Dimentions.radius20 * 0.5,
                          ),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.location_on,
                              size: Dimentions.height25,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: Dimentions.width10,
                            ),
                            Expanded(
                              child: Text(
                                locationController.pickplaceMark.name ??
                                    'Pick your address',
                                style: TextStyle(
                                    fontSize: Dimentions.font15,
                                    color: Colors.white),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            SizedBox(
                              width: Dimentions.width10,
                            ),
                            Icon(
                              Icons.search,
                              size: 25,
                              color: AppColors.yellowColor,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: Dimentions.height20 * 4,
                    left: Dimentions.width20,
                    right: Dimentions.width20,
                    child: locationController.isLoading
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : CustomButton(
                            buttonText: locationController.inZone
                                ? widget.fromAddress
                                    ? 'Pick Address'
                                    : 'Pick Location'
                                : 'Service not available in your area',
                            onPressed: (locationController.buttonDisabled ||
                                    locationController.loading)
                                ? null
                                : () {
                                    if (locationController
                                                .pickPosition.latitude !=
                                            0 &&
                                        locationController.pickplaceMark.name !=
                                            null) {
                                      if (widget.fromAddress) {
                                        if (widget.googleMapController !=
                                            null) {
                                          widget.googleMapController.moveCamera(
                                            CameraUpdate.newCameraPosition(
                                              CameraPosition(
                                                target: LatLng(
                                                  locationController
                                                      .pickPosition.latitude,
                                                  locationController
                                                      .pickPosition.longitude,
                                                ),
                                                zoom: 17,
                                              ),
                                            ),
                                          );
                                          locationController.setAddressData();
                                        }
                                        Get.back(); //creates update problem
                                      }
                                    }
                                  },
                          ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
