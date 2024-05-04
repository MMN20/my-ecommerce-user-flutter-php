import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_eccommerce_user/controller/item_details_page_controller.dart';
import 'package:my_eccommerce_user/core/utils/colors.dart';
import 'package:my_eccommerce_user/core/functions/handle_request_data.dart';
import 'package:my_eccommerce_user/core/functions/validator.dart';
import 'package:my_eccommerce_user/core/request_status.dart';
import 'package:my_eccommerce_user/core/utils/currency.dart';
import 'package:my_eccommerce_user/data/data_source/remote/cart_data.dart';
import 'package:my_eccommerce_user/data/data_source/remote/coupon_data.dart';
import 'package:my_eccommerce_user/data/model/cart_model.dart';
import 'package:my_eccommerce_user/data/model/item_model.dart';
import 'package:my_eccommerce_user/routes.dart';
import 'package:my_eccommerce_user/view/widgets/cart_page/small_button.dart';
import 'package:my_eccommerce_user/view/widgets/general_button.dart';
import 'package:my_eccommerce_user/view/widgets/my_text_form_field.dart';

class CartPageController extends GetxController {
  List<CartModel> carts = [];
  RequestStatus requestStatus = RequestStatus.none;
  bool isCameFromItemDetailsPage = false;
  int? couponDiscount;
  TextEditingController couponController = TextEditingController();
  double priceAfterCoupon = 0;
  double totalPrice = 0;
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  bool isInfoBottomSheetLoading = false;
  int usedCouponID = 0;

  Future<void> getAllCarts() async {
    carts.clear();
    requestStatus = RequestStatus.loading;
    update();
    dynamic response = await CartData.getAllCarts();
    requestStatus = hanldeRequestData(response);
    if (requestStatus == RequestStatus.success) {
      if (response['status'] == 'success') {
        carts.clear();
        List responseData = response['data'];
        carts.addAll(responseData.map((e) => CartModel.fromJson(e)));
      }
    }
    update();
  }

  void updateItemDetailsPage() {
    if (isCameFromItemDetailsPage) {
      final controller = Get.find<ItemDetailsPageController>();
      controller.deletingFromCartUIUpdates();
      controller.update();
      controller.updateItemsListPage();
    }
  }

  Future<void> updateCartAmount(CartModel cart, int newAmount) async {
    requestStatus = RequestStatus.loading;
    update();
    dynamic response = await CartData.updateCartAmount(
        cart.cartID.toString(), newAmount.toString());
    requestStatus = hanldeRequestData(response);
    if (requestStatus == RequestStatus.success) {
      if (response['status'] == "success") {
        cart.amount = newAmount;
        if (newAmount <= 0) {
          carts.remove(cart);
          updateItemDetailsPage();
        }
      } else {
        //! failed to change the amount
      }
    }
    update();
  }

  void goToItemDetailsPage(ItemModel item) {
    Get.toNamed(AppRoutes.itemDetails, arguments: {"item": item});
  }

  void setPriceAfterCoupon() {
    if (couponDiscount != null) {
      priceAfterCoupon = totalPrice - (totalPrice * (couponDiscount! / 100));
    }
  }

  void setTotalPrice() {
    totalPrice = 0;
    for (CartModel cart in carts) {
      totalPrice += (cart.item.priceAfterDiscount! * cart.amount);
    }
  }

  Future<void> checkCoupon() async {
    if (formState.currentState!.validate()) {
      isInfoBottomSheetLoading = true;
      update();
      dynamic response = await CouponData.checkCoupon(couponController.text);
      RequestStatus requestStatus = hanldeRequestData(response);
      if (requestStatus == RequestStatus.success) {
        if (response['status'] == 'success') {
          couponDiscount = response['amount'];
          usedCouponID = response['id'];
          couponController.text = "";
          setPriceAfterCoupon();
        } else {
          //! the entered coupon is wrong
        }
      }
      isInfoBottomSheetLoading = false;
      update();
    }
  }

  void deleteTheCurrentCoupon() {
    couponDiscount = null;
    priceAfterCoupon = 0;
    couponController.text = "";
    usedCouponID = 0;
    update();
  }

  void showInfoBottomSheet() async {
    // to make sure all the infos are up-to-date and correct
    await getAllCarts();

    setTotalPrice();

    Get.bottomSheet(
      BottomSheet(
        onClosing: () {},
        builder: (context) {
          return GetBuilder(
              init: this,
              builder: (controller) {
                return Container(
                  height: Get.height * 0.4,
                  padding: const EdgeInsets.all(10),
                  child: isInfoBottomSheetLoading
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                Text(
                                    "Total price: ${getPriceAndCurrency(totalPrice)}",
                                    style: (couponDiscount != null)
                                        ? const TextStyle(
                                            decoration:
                                                TextDecoration.lineThrough)
                                        : null),
                              ],
                            ),
                            if (couponDiscount != null)
                              Row(
                                children: [
                                  const Text("After coupon: "),
                                  Text("${priceAfterCoupon}"),
                                  const SizedBox(width: 10),
                                  GeneralButton(
                                    onPressed: () {
                                      deleteTheCurrentCoupon();
                                    },
                                    child: const Text("Remove"),
                                  ),
                                ],
                              ),
                            if (couponDiscount == null)
                              Row(
                                children: [
                                  Expanded(
                                    child: Form(
                                      key: formState,
                                      child: MyTextFormField(
                                        validator: (p0) {
                                          return validator(
                                              p0!,
                                              1,
                                              p0.length,
                                              "Please enter the coupon",
                                              "",
                                              false,
                                              "Please enter the coupon");
                                        },
                                        labelText: "Coupon",
                                        icon:
                                            const Icon(Icons.discount_outlined),
                                        controller: couponController,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  GeneralButton(
                                      onPressed: () {
                                        checkCoupon();
                                      },
                                      child: const Text("Enter"))
                                ],
                              ),
                            const SizedBox(height: 15),
                            GeneralButton(
                              onPressed: () {
                                goToOrderingPage();
                              },
                              child: const Text("Order"),
                            ),
                            const Text(
                              "Please note that there will be a delivery price also",
                              style: TextStyle(fontSize: 12),
                            )
                          ],
                        ),
                );
              });
        },
      ),
    );
  }

  void showAmountExceedsQtyDialog() {
    Get.dialog(const Dialog(
      child: Padding(
        padding: EdgeInsets.all(15),
        child: Text(
          "The amount exceeds the quantity of the item",
          textAlign: TextAlign.center,
        ),
      ),
    ));
  }

  void goToOrderingPage() {
    for (var cart in carts) {
      if (cart.item.itemsQty! < cart.amount) {
        showAmountExceedsQtyDialog();
        return;
      }
    }
    double priceToSend;
    if (couponDiscount == null) {
      priceToSend = totalPrice;
    } else {
      priceToSend = priceAfterCoupon;
    }

    Get.toNamed(AppRoutes.checkoutPage,
        arguments: {"orderPrice": priceToSend, "couponID": usedCouponID});
  }

  void showBottomSheet(CartModel cart) {
    int tempAmount = cart.amount;
    Get.bottomSheet(
      GetBuilder(
          init: this,
          builder: (context) {
            return BottomSheet(
              onClosing: () {},
              builder: (context) {
                return Container(
                  height: Get.height * 0.35,
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          goToItemDetailsPage(cart.item);
                        },
                        child: Text(
                          cart.item.itemsName!,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SmallButton(
                            cart: cart,
                            onTap: () {
                              tempAmount++;
                              update();
                            },
                            child: const Icon(
                              Icons.add,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Text(tempAmount.toString()),
                          const SizedBox(width: 10),
                          SmallButton(
                            cart: cart,
                            onTap: () {
                              if (tempAmount > 0) {
                                tempAmount--;
                                update();
                              }
                            },
                            child: const Icon(
                              Icons.remove,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      MaterialButton(
                        onPressed: () async {
                          await updateCartAmount(cart, tempAmount);
                          if (cart.amount == tempAmount) {
                            Get.back();
                          }
                        },
                        color: tempAmount > 0
                            ? AppColors.thirdColor10
                            : Colors.red,
                        textColor: Colors.white,
                        child: Text(tempAmount > 0 ? "Save" : "Delete"),
                      )
                    ],
                  ),
                );
              },
            );
          }),
    );
  }

  @override
  void onInit() {
    getAllCarts();
    if (Get.arguments != null) {
      isCameFromItemDetailsPage = Get.arguments['isItemDetails'] ?? false;
    }
    super.onInit();
  }
}
