import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_eccommerce_user/controller/settings/orders/orders_page_controller.dart';
import 'package:my_eccommerce_user/core/utils/colors.dart';
import 'package:my_eccommerce_user/core/utils/currency.dart';
import 'package:my_eccommerce_user/data/model/order_model.dart';
import 'package:my_eccommerce_user/view/widgets/request_status_view.dart';
import 'package:my_eccommerce_user/view/widgets/settings_page/orders_page/order_card.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OrdersPageController());
    return Scaffold(
      appBar: AppBar(
        title: const Text("Orders"),
        centerTitle: true,
      ),
      body: GetBuilder(
          init: controller,
          builder: (controller) {
            return RequestStatusView(
              onErrorTap: () {},
              requestStatus: controller.requestStatus,
              child: SafeArea(
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemCount: controller.orders.length,
                  separatorBuilder: (context, index) {
                    return const SizedBox(height: 15);
                  },
                  itemBuilder: (context, index) {
                    OrderModel order = controller.orders[index];
                    double orderPrice;
                    if (order.isUsedCoupon == 1) {
                      orderPrice = order.priceAfterCoupon!;
                    } else {
                      orderPrice = order.fullPrice!;
                    }
                    return OrderCard(
                      color: index.isEven
                          ? AppColors.secondColor30
                          : AppColors.mainColor60,
                      orderModel: order,
                      onDeleteTap: () {
                        controller.showDeletingDialog(order);
                      },
                      onDetailsTap: () {
                        controller.goToOrderDetailsPage(order);
                      },
                      values: [
                        OrderValue(
                            name: "Order ID", value: order.ordersId.toString()),
                        OrderValue(
                            name: "Status", value: order.orderStatusName!),
                        if (order.addressesName != null)
                          OrderValue(
                              name: "Address", value: order.addressesName!),
                        OrderValue(
                            name: "Order type", value: order.ordersTypeName!),
                        OrderValue(
                            name: "Price",
                            value: getPriceAndCurrency(orderPrice)),
                        if (order.ordersDeliveryprice != null)
                          OrderValue(
                              name: "Delivering Price",
                              value: getPriceAndCurrency(
                                  order.ordersDeliveryprice!)),
                        OrderValue(
                            name: "Payment method",
                            value: order.paymentMethodsName!),
                      ],
                    );
                  },
                ),
              ),
            );
          }),
    );
  }
}
