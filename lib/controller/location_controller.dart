import 'dart:convert';

import 'package:food_delivery_app/data/repository/location_repo.dart';
import 'package:food_delivery_app/models/address_model.dart';
import 'package:food_delivery_app/models/response_model.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationController extends GetxController implements GetxService {
  final LocationRepo locationRepo;

  bool _loading = false;
  late Position _position;
  late Position _pickPosition;
  Placemark _placeMark = Placemark();
  Placemark _pickplaceMark = Placemark();

  List<AddressModel> _addressList = [];

  late GoogleMapController _mapController;
  bool _updateAddressData = true;
  bool _changedAddress = true;

  LocationController({required this.locationRepo});

  List<AddressModel> get addressList => _addressList;

  bool get loading => _loading;
  Position get postion => _position;
  Position get pickPosition => _pickPosition;
  Placemark get placeMark => _placeMark;
  Placemark get pickplaceMark => _pickplaceMark;

  void setMapController(GoogleMapController mapController) {
    _mapController = mapController;
  }

  void updatePosition(CameraPosition position, bool fromAddress) async {
    if (_updateAddressData) {
      _loading = true;
      update();

      try {
        if (fromAddress) {
          _position = Position(
            longitude: position.target.longitude,
            latitude: position.target.latitude,
            timestamp: DateTime.now(),
            accuracy: 1,
            altitude: 1,
            heading: 1,
            speed: 1,
            speedAccuracy: 1,
          );
        } else {
          _pickPosition = Position(
            longitude: position.target.longitude,
            latitude: position.target.latitude,
            timestamp: DateTime.now(),
            accuracy: 1,
            altitude: 1,
            heading: 1,
            speed: 1,
            speedAccuracy: 1,
          );
        }

        if (_changedAddress) {
          String address = await getAddressfromGeoCode(LatLng(
            position.target.latitude,
            position.target.longitude,
          ));
          fromAddress
              ? _placeMark = Placemark(name: address)
              : _pickplaceMark = Placemark(name: address);
        }
      } catch (e) {
        print(e);
      }
    }
  }

  Future<String> getAddressfromGeoCode(LatLng latlng) async {
    String address = "Unknown location found";

    Response response = await locationRepo.getAddressfromGeoCode(latlng);

    if (response.body["status"] == 'OK') {
      address = response.body['results'][0]['formatted_address'].toString();
    } else {
      print("Error getting the google api");
    }

    return address;
  }

  late Map<String, dynamic> _getAddress;
  Map get getAddress => _getAddress;

  AddressModel getUserAddress() {
    late AddressModel addressModel;

    //converting to map using jsondecode
    _getAddress = jsonDecode(locationRepo.getUserAddress());

    try {
      addressModel =
          AddressModel.fromJson(jsonDecode(locationRepo.getUserAddress()));
    } catch (e) {
      print(e);
    }
    return addressModel;
  }

  final List<String> _addressTypeList = ["home", "office", "others"];
  List<String> get addressTypeList => _addressTypeList;

  int _addressTypeIndex = 0;
  int get addressTypeIndex => _addressTypeIndex;

  void setAddressTypeIndex(int index) {
    _addressTypeIndex = index;
    update();
  }

  Future<ResponseModel> addAddress(AddressModel addressModel) async {
    _loading = true;
    update();

    Response response = await locationRepo.addAddress(addressModel);

    ResponseModel responseModel;
    if (response.statusCode == 200) {
      await getAddressList();
      String message = response.body["message"];
      responseModel = ResponseModel(true, message);
      await saveUserAddress(addressModel);
    } else {
      print("couldn't save the address");
      responseModel = ResponseModel(false, response.statusText!);
    }

    update();
    return responseModel;
  }

  late List<AddressModel> _allAddressList = [];
  List<AddressModel> get allAddressList => _allAddressList;

  Future<void> getAddressList() async {
    Response response = await locationRepo.getAllAddress();

    if (response.statusCode == 200) {
      _addressList = [];
      _allAddressList = [];

      response.body.forEach((address) {
        _addressList.add(AddressModel.fromJson(address));
        _allAddressList.add(AddressModel.fromJson(address));
      });
    } else {
      _addressList = [];
      _allAddressList = [];
    }
    update();
  }

  Future<bool> saveUserAddress(AddressModel addressModel) async {
    String userAddress = jsonEncode(addressModel.toJson());

    return await locationRepo.saveUserAddress(userAddress);
  }

  void clearAddressList() {
    _addressList = [];
    _allAddressList = [];
    update();
  }
}
