import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:my_eccommerce_user/controller/ordering_page_controller.dart';
import 'package:my_eccommerce_user/controller/settings/addresses/addresses_page_controller.dart';
import 'package:my_eccommerce_user/core/functions/handle_request_data.dart';
import 'package:my_eccommerce_user/core/request_status.dart';
import 'package:my_eccommerce_user/data/data_source/remote/addresses_data.dart';
import 'package:my_eccommerce_user/data/model/address.dart';

class AddAddressesPageController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController descController = TextEditingController();
  GlobalKey<FormState> formState = GlobalKey<FormState>();

  double? lat;
  double? long;
  RequestStatus requestStatus = RequestStatus.none;

  bool isFromAddressesPage = true;

  bool validateForm() {
    return formState.currentState!.validate();
  }

  Future<void> addAddress() async {
    if (!validateForm()) {
      return;
    }

    if (!(await checkLocationPermission())) {
      return;
    }

    requestStatus = RequestStatus.loading;
    update();

    if (lat == null && long == null) {
      Position currentPosition = await getCurrentUserPosition();
      lat = currentPosition.latitude;
      long = currentPosition.longitude;
    }

    dynamic response = await AddressesData.addAddress(nameController.text,
        descController.text, lat.toString(), long.toString());
    requestStatus = hanldeRequestData(response);
    if (requestStatus == RequestStatus.success) {
      //! get the id of the added thing
      Address address = Address(
        addressesId: response['newID'],
        addressesName: nameController.text,
        addressesLat: lat,
        addressesLong: long,
        addressesDesc: descController.text,
        addressesUserid: response['newID'],
      );
      addTheNewAddressToPerviousPage(address);
      Get.back();
    }
    update();
  }

  Future<Position> getCurrentUserPosition() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
    return position;
  }

  void addTheNewAddressToPerviousPage(Address address) {
    if (isFromAddressesPage) {
      final controller = Get.find<AddressesPageController>();
      controller.addresses.add(address);
      controller.update();
    } else {
      final controller = Get.find<OrderingPageController>();
      controller.addersses.add(address);
      controller.update();
    }
  }

  Future<bool> checkLocationPermission() async {
    bool isLocationEnabled = await Geolocator.isLocationServiceEnabled();
    if (!isLocationEnabled) {
      Get.dialog(
        const Dialog(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Text("You must enable the location service first"),
          ),
        ),
      );
      return false;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    Widget failedDialog = const Dialog(
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Text("You must give the location permission to continue!"),
      ),
    );
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        Get.dialog(
          failedDialog,
        );
        return false;
      }
    }
    if (permission == LocationPermission.denied) {
      Get.dialog(
        failedDialog,
      );
      return false;
    }

    if (permission == LocationPermission.whileInUse ||
        permission == LocationPermission.always) {
      return true;
    }

    return true;
  }

  @override
  void onInit() {
    if (Get.arguments != null) {
      isFromAddressesPage = Get.arguments['isAddressesPage'];
    }
    super.onInit();
  }
}
