import 'package:get/get.dart';
import 'package:my_eccommerce_user/core/functions/handle_request_data.dart';
import 'package:my_eccommerce_user/core/request_status.dart';
import 'package:my_eccommerce_user/data/data_source/remote/orders_data.dart';
import 'package:my_eccommerce_user/data/model/order_model.dart';
import 'package:my_eccommerce_user/routes.dart';

class ArchivedOrdersPageController extends GetxController {
  List<OrderModel> orders = [];
  RequestStatus requestStatus = RequestStatus.none;

  Future<void> getAllArchivedOrders() async {
    requestStatus = RequestStatus.loading;
    update();
    dynamic response = await OrdersData.getArchivedOrders();
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

  void goToOrderDetailsPage(OrderModel orderModel) {
    Get.toNamed(AppRoutes.orderDetailsPage,
        arguments: {'orderModel': orderModel});
  }

  @override
  void onInit() {
    getAllArchivedOrders();
    super.onInit();
  }
}
