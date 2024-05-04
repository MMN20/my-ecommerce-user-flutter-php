import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_eccommerce_user/controller/ordering_page_controller.dart';
import 'package:my_eccommerce_user/core/assets/images.dart';
import 'package:my_eccommerce_user/core/utils/colors.dart';
import 'package:my_eccommerce_user/view/widgets/checkout_page/payment_method_item.dart';
import 'package:my_eccommerce_user/view/widgets/checkout_page/title.dart';
import 'package:my_eccommerce_user/view/widgets/general_button.dart';
import 'package:my_eccommerce_user/view/widgets/request_status_view.dart';

class OrderingPage extends StatelessWidget {
  const OrderingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OrderingPageController());
    return Material(
      child: GetBuilder<OrderingPageController>(builder: (controller) {
        return RequestStatusView(
          onErrorTap: () {},
          requestStatus: controller.requestStatus,
          child: Scaffold(
            backgroundColor: AppColors.mainColor60,
            body: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView(
                    children: [
                      const SelectionTitle(text: "Choose payment method"),
                      Row(
                        children: [
                          PaymentMethodItem(
                            onTap: () {
                              controller.changeSelecetdPaymentMethod(
                                  enPaymentMethods.creditCard);
                            },
                            assetName: AppImageAssets.creditCard,
                            isSelected: controller.selectedPaymentMethod ==
                                enPaymentMethods.creditCard,
                            name: "Credit card",
                          ),
                          const SizedBox(width: 10),
                          PaymentMethodItem(
                            onTap: () {
                              controller.changeSelecetdPaymentMethod(
                                  enPaymentMethods.onDelivery);
                            },
                            assetName: AppImageAssets.onDelivery,
                            isSelected: controller.selectedPaymentMethod ==
                                enPaymentMethods.onDelivery,
                            name: "On delivery",
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      const SelectionTitle(text: "Choose delivery type"),
                      Row(
                        children: [
                          PaymentMethodItem(
                            onTap: () {
                              controller.changeSelecetdDeliveryType(
                                  enDeliveryType.delivery);
                            },
                            assetName: AppImageAssets.onDelivery,
                            isSelected: controller.selectedDeliveryType ==
                                enDeliveryType.delivery,
                            name: "Delivery",
                          ),
                          const SizedBox(width: 10),
                          PaymentMethodItem(
                            onTap: () {
                              controller.changeSelecetdDeliveryType(
                                  enDeliveryType.receive);
                            },
                            assetName: AppImageAssets.onDelivery,
                            isSelected: controller.selectedDeliveryType ==
                                enDeliveryType.receive,
                            name: "Receive",
                          ),
                        ],
                      ),
                      if (controller.selectedDeliveryType ==
                          enDeliveryType.delivery)
                        Column(
                          children: [
                            const SizedBox(height: 10),
                            ...List.generate(
                              controller.addersses.length,
                              (index) {
                                bool isSelected =
                                    controller.selectedAddressIndex == index;
                                Color? textColor =
                                    isSelected ? Colors.white : null;
                                return InkWell(
                                  onTap: () {
                                    controller
                                        .changeSelectedAddressIndex(index);
                                  },
                                  child: Card(
                                    color: isSelected
                                        ? AppColors.thirdColor10
                                        : Colors.white,
                                    elevation: 5,
                                    child: ListTile(
                                      title: Text(
                                          controller
                                              .addersses[index].addressesName!,
                                          style: TextStyle(color: textColor)),
                                      subtitle: Text(
                                          controller
                                              .addersses[index].addressesDesc!,
                                          style: TextStyle(color: textColor)),
                                      trailing: Icon(
                                        Icons.location_on_outlined,
                                        color: textColor,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            )
                          ],
                        ),
                      const SizedBox(height: 25),
                      Row(
                        children: [
                          GeneralButton(
                            onPressed: () {
                              controller.goToAddNewAddressPage();
                            },
                            child: const Text("Add a new address"),
                          ),
                        ],
                      ),
                      const SizedBox(height: 150)
                    ],
                  ),
                ),
                Positioned(
                  bottom: 30,
                  left: 50,
                  right: 50,
                  child: GeneralButton(
                    onPressed: () {
                      controller.showAreYouSureDialog();
                    },
                    child: const Text("Order"),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
