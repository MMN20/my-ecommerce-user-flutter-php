import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:my_eccommerce_user/core/functions/handle_request_data.dart';
import 'package:my_eccommerce_user/core/request_status.dart';
import 'package:my_eccommerce_user/data/data_source/remote/addresses_data.dart';
import 'package:my_eccommerce_user/data/model/address.dart';
import 'package:my_eccommerce_user/data/model/user.dart';
import 'package:my_eccommerce_user/routes.dart';

class AddressesPageController extends GetxController {
  List<Address> addresses = [];
  RequestStatus requestStatus = RequestStatus.none;

  Future<void> getAllAddresses() async {
    requestStatus = RequestStatus.loading;
    update();
    dynamic response = await AddressesData.getAllAddresses();
    requestStatus = hanldeRequestData(response);
    if (requestStatus == RequestStatus.success) {
      if (response['status'] == 'success') {
        List responseData = response['data'];
        addresses.addAll(responseData.map((e) => Address.fromJson(e)).toList());
      } else {
        requestStatus = RequestStatus.empty;
      }
    }
    update();
  }

  // if this return true then the LocationPermission is granted else return false
  Future<bool> checkLocationPermission() async {
    bool isLocationEnabled = await Geolocator.isLocationServiceEnabled();
    if (!isLocationEnabled) {
      Get.dialog(
        const Dialog(
          child: Text("You must enable the location service first"),
        ),
      );
      return false;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        Get.dialog(
          const Dialog(
            child: Text("You must give the location permission to continue!"),
          ),
        );
        return false;
      }
    }
    if (permission == LocationPermission.denied) {
      Get.dialog(
        const Dialog(
          child: Text("You must give the location permission to continue!"),
        ),
      );
      return false;
    }

    if (permission == LocationPermission.whileInUse ||
        permission == LocationPermission.always) {
      return true;
    }

    return true;
  }

  Future<void> deleteAnAddress(int index) async {
    requestStatus = RequestStatus.loading;
    update();
    dynamic response = await AddressesData.deleteAddress(
        addresses[index].addressesId.toString());
    requestStatus = hanldeRequestData(response);
    if (requestStatus == RequestStatus.success) {
      if (response['status'] == 'success') {
        addresses.removeWhere(
            (element) => element.addressesId == addresses[index].addressesId);
      } else if (response['status'] == 'failure' &&
          response['message'] == 'order') {
        Get.snackbar("Error",
            "This address is associated with an order so it can't be deleted now");
      } else {
        Get.snackbar("Error", "An error occurred while deleting the address");
      }
    }
    update();
  }

  void goToAddAddressPage() async {
    if (await checkLocationPermission()) {
      Get.toNamed(AppRoutes.addAddress); // go to address add page
    }
  }

  @override
  void onInit() {
    getAllAddresses();
    super.onInit();
  }
}
