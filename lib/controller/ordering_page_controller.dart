import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_eccommerce_user/core/functions/handle_request_data.dart';
import 'package:my_eccommerce_user/core/request_status.dart';
import 'package:my_eccommerce_user/core/utils/currency.dart';
import 'package:my_eccommerce_user/data/data_source/remote/addresses_data.dart';
import 'package:my_eccommerce_user/data/data_source/remote/orders_data.dart';
import 'package:my_eccommerce_user/data/model/address.dart';
import 'package:my_eccommerce_user/data/model/user.dart';
import 'package:my_eccommerce_user/routes.dart';
import 'package:my_eccommerce_user/view/widgets/general_button.dart';

enum enPaymentMethods { creditCard, onDelivery }

enum enDeliveryType { delivery, receive }

class OrderingPageController extends GetxController {
  enPaymentMethods? selectedPaymentMethod;
  enDeliveryType? selectedDeliveryType;

  RequestStatus requestStatus = RequestStatus.none;
  int? selectedAddressIndex;
  late double orderPrice;
  late int couponid;

  List<Address> addersses = [];

  String getCurrentDeliveryTypeName() {
    return selectedDeliveryType == enDeliveryType.delivery
        ? "Delivery"
        : "Receive";
  }

  String getCurrentPaymentMethodName() {
    return selectedPaymentMethod == enPaymentMethods.creditCard
        ? "Credit card"
        : "On delivery";
  }

  void changeSelecetdPaymentMethod(enPaymentMethods paymentMethod) {
    if (paymentMethod != selectedPaymentMethod) {
      selectedPaymentMethod = paymentMethod;
      update();
    }
  }

  void changeSelecetdDeliveryType(enDeliveryType deliveryType) {
    if (deliveryType != selectedDeliveryType) {
      selectedDeliveryType = deliveryType;
      update();
    }
  }

  void changeSelectedAddressIndex(int index) {
    if (index != selectedAddressIndex) {
      selectedAddressIndex = index;
      update();
    }
  }

  Future<void> getAllAddresses() async {
    requestStatus = RequestStatus.loading;
    update();
    dynamic response = await AddressesData.getAllAddresses();
    requestStatus = hanldeRequestData(response);
    if (requestStatus == RequestStatus.success) {
      List responseData = response['data'];
      addersses = responseData.map((e) => Address.fromJson(e)).toList();
    }
    update();
  }

  // this function will send the current order infos (price and delivery price if chosen)
  Future<void> saveTheOrder() async {
    requestStatus = RequestStatus.loading;
    update();
    String addressid;
    if (selectedDeliveryType == enDeliveryType.receive) {
      addressid = "0";
    } else {
      addressid = addersses[selectedAddressIndex!].addressesId.toString();
    }

    String orderTypeID =
        selectedDeliveryType == enDeliveryType.delivery ? "1" : "2";
    String deliveryPrice =
        selectedDeliveryType == enDeliveryType.delivery ? "5" : "0";
    String couponID = couponid.toString();
    String paymentMethod =
        selectedPaymentMethod == enPaymentMethods.creditCard ? "1" : "2";

    dynamic response = await OrdersData.addNewOrder(
        addressid, orderTypeID, deliveryPrice, couponID, paymentMethod);
    requestStatus = hanldeRequestData(response);
    if (requestStatus == RequestStatus.success) {
      Get.offAllNamed(AppRoutes.mainScreen);
      Get.snackbar("Gongrats", "Your order has been saved");
    }
    update();
  }

  bool isValidInputs() {
    if (selectedPaymentMethod != null && selectedDeliveryType != null) {
      if (selectedDeliveryType == enDeliveryType.delivery &&
          selectedAddressIndex == null) {
        Get.dialog(
          Dialog(
            child: SizedBox(
              height: Get.height * 0.3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Please choose the address"),
                  GeneralButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: const Text("OK"),
                  ),
                ],
              ),
            ),
          ),
        );
        return false;
      }
      return true;
    } else {
      Get.dialog(
        Dialog(
          child: SizedBox(
            height: Get.height * 0.3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Please enter all the information first",
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                GeneralButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: const Text("OK"),
                ),
              ],
            ),
          ),
        ),
      );
    }
    return false;
  }

  void showAreYouSureDialog() {
    if (!isValidInputs()) {
      return;
    }
    Get.dialog(
      Dialog(
        child: Container(
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Are you sure that you entered the correct information?",
                textAlign: TextAlign.center,
              ),
              Text("Price: ${getPriceAndCurrency(orderPrice)}"),
              if (selectedDeliveryType == enDeliveryType.delivery &&
                  selectedAddressIndex != null)
                const Text(
                  "There will be 5\$ for the delivery",
                  style: TextStyle(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              Text("Type: ${getCurrentDeliveryTypeName()}",
                  textAlign: TextAlign.center),
              Text(
                "Payment method: ${getCurrentPaymentMethodName()}",
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GeneralButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: const Text("Cancel"),
                  ),
                  const SizedBox(width: 20),
                  GeneralButton(
                    onPressed: () {
                      Get.back();
                      saveTheOrder();
                    }, //! here call the method that will save the current order to the database
                    child: const Text("Confirm"),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void goToAddNewAddressPage() {
    Get.toNamed(AppRoutes.addAddress, arguments: {"isAddressesPage": false});
  }

  @override
  void onInit() {
    getAllAddresses();
    orderPrice = Get.arguments['orderPrice'];
    couponid = Get.arguments['couponID'];
    super.onInit();
  }
}
