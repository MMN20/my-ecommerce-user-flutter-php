import 'package:get/get.dart';
import 'package:my_eccommerce_user/core/functions/handle_request_data.dart';
import 'package:my_eccommerce_user/core/request_status.dart';
import 'package:my_eccommerce_user/data/data_source/remote/orders_data.dart';
import 'package:my_eccommerce_user/data/model/cart_model.dart';
import 'package:my_eccommerce_user/data/model/item_model.dart';
import 'package:my_eccommerce_user/data/model/order_model.dart';
import 'package:my_eccommerce_user/routes.dart';

class OrderDetailsPageController extends GetxController {
  late OrderModel orderModel;
  List<CartModel> items = [];
  RequestStatus requestStatus = RequestStatus.none;

  Future<void> getAllItems() async {
    requestStatus = RequestStatus.loading;
    update();
    // await Future.delayed(Duration(seconds: 3));
    dynamic response =
        await OrdersData.getOrderItems(orderModel.ordersId.toString());
    requestStatus = hanldeRequestData(response);
    if (requestStatus == RequestStatus.success) {
      if (response['status'] == 'success') {
        List responseData = response['data'];
        items = List.generate(responseData.length,
            (index) => CartModel.fromJson(responseData[index]));
      } else {
        requestStatus = RequestStatus.empty;
      }
    }
    update();
  }

  void goToItemDetailsPage(ItemModel item) {
    Get.toNamed(AppRoutes.itemDetails, arguments: {"item": item});
  }

  void goToTrackingPage() {
    Get.toNamed(AppRoutes.orderTrackingPage,
        arguments: {"orderModel": orderModel});
  }

  @override
  void onInit() {
    orderModel = Get.arguments['orderModel'];
    getAllItems();
    super.onInit();
  }
}
