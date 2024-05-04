import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_eccommerce_user/controller/cart_page_controller.dart';
import 'package:my_eccommerce_user/core/utils/colors.dart';
import 'package:my_eccommerce_user/data/model/cart_model.dart';
import 'package:my_eccommerce_user/view/widgets/cart_page/cart_item.dart';
import 'package:my_eccommerce_user/view/widgets/request_status_view.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    print("======================== CartPaeg");
    Get.delete<CartPageController>();

    final controller = Get.put(CartPageController());
    return Scaffold(
      body: GetBuilder<CartPageController>(builder: (controller) {
        return RequestStatusView(
          onErrorTap: () {},
          requestStatus: controller.requestStatus,
          child: Scaffold(
              appBar: AppBar(
                actions: [
                  IconButton(
                      onPressed: () {
                        controller.showInfoBottomSheet();
                      },
                      icon: const Icon(
                        Icons.info,
                        color: AppColors.thirdColor10,
                      ))
                ],
                centerTitle: true,
                title: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("Cart"),
                    SizedBox(width: 5),
                    Icon(Icons.shopping_cart_outlined)
                  ],
                ),
              ),
              body: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  itemCount: controller.carts.length,
                  itemBuilder: (context, index) {
                    CartModel cart = controller.carts[index];
                    return CartItem(
                      amount: cart.amount,
                      onCartTap: () {
                        controller.showBottomSheet(cart);
                      },
                      onIncreaseAmount: () {
                        controller.updateCartAmount(cart, cart.amount + 1);
                      },
                      onDecreaseAmount: () {
                        controller.updateCartAmount(cart, cart.amount - 1);
                      },
                      showIncreaseDecrease: true,
                      cart: cart,
                    );
                  },
                ),
              )),
        );
      }),
    );
  }
}
