import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_eccommerce_user/core/functions/handle_request_data.dart';
import 'package:my_eccommerce_user/core/request_status.dart';
import 'package:my_eccommerce_user/data/data_source/remote/orders_data.dart';
import 'package:my_eccommerce_user/data/model/order_model.dart';
import 'package:my_eccommerce_user/routes.dart';
import 'package:my_eccommerce_user/view/widgets/general_button.dart';

class OrdersPageController extends GetxController {
  List<OrderModel> orders = [];
  RequestStatus requestStatus = RequestStatus.none;

  Future<void> getAllOrders() async {
    requestStatus = RequestStatus.loading;
    update();
    dynamic response = await OrdersData.getAllOrders();
    requestStatus = hanldeRequestData(response);
    if (requestStatus == RequestStatus.success) {
      if (response['status'] == 'success') {
        List responseData = response['data'];
        orders.addAll(responseData.map((e) => OrderModel.fromJson(e)));
      } else {
        requestStatus = RequestStatus.empty;
      }
    }
    update();
  }

  // can be deleted only when the status is (Pending)
  Future<void> deleteOrder(OrderModel order) async {
    requestStatus = RequestStatus.loading;
    update();
    dynamic response = await OrdersData.deleteOrder(order.ordersId.toString());
    requestStatus = hanldeRequestData(response);
    if (requestStatus == RequestStatus.success) {
      if (response['status'] == 'success') {
        orders.remove(order);
      } else {
        Get.snackbar("Error", "There was an error while deleting the order");
      }
    }
    update();
  }

  void showDeletingDialog(OrderModel order) {
    Get.dialog(Dialog(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("Are you sure that you want to delete the order?"),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GeneralButton(
                    onPressed: () {
                      Get.back();
                      deleteOrder(order);
                    },
                    child: const Text("Confirm")),
                const SizedBox(width: 10),
                GeneralButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: const Text("Cancel")),
              ],
            )
          ],
        ),
      ),
    ));
  }

  void goToOrderDetailsPage(OrderModel orderModel) {
    Get.toNamed(AppRoutes.orderDetailsPage,
        arguments: {'orderModel': orderModel});
  }

  @override
  void onInit() {
    getAllOrders();
    super.onInit();
  }
}
