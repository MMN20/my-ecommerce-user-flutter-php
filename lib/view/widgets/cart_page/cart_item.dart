import 'package:flutter/material.dart';
import 'package:my_eccommerce_user/api_links.dart';
import 'package:my_eccommerce_user/core/utils/colors.dart';
import 'package:my_eccommerce_user/core/utils/currency.dart';
import 'package:my_eccommerce_user/data/model/cart_model.dart';
import 'package:my_eccommerce_user/view/widgets/cart_page/small_button.dart';

class CartItem extends StatelessWidget {
  const CartItem(
      {super.key,
      required this.cart,
      required this.onCartTap,
      this.onIncreaseAmount,
      this.onDecreaseAmount,
      required this.showIncreaseDecrease,
      required this.amount});
  final CartModel cart;
  final void Function() onCartTap;
  final void Function()? onIncreaseAmount;
  final void Function()? onDecreaseAmount;
  final bool showIncreaseDecrease;
  final int amount;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onCartTap,
      child: Card(
        margin: const EdgeInsets.only(bottom: 10),
        child: ListTile(
          subtitle: Text(
            "${getPriceAndCurrency(amount * cart.item.priceAfterDiscount!)} (${getPriceAndCurrency(cart.item.priceAfterDiscount!)})",
            style: const TextStyle(fontSize: 16),
          ),
          trailing: !showIncreaseDecrease
              ? Text(amount.toString())
              : Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SmallButton(
                      cart: cart,
                      onTap: onIncreaseAmount ?? () {},
                      child: const Icon(
                        Icons.add,
                        color: AppColors.secondColor30,
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(amount.toString()),
                    const SizedBox(
                      width: 5,
                    ),
                    SmallButton(
                      cart: cart,
                      onTap: onDecreaseAmount ?? () {},
                      child: Icon(
                        cart.amount > 1 ? Icons.remove : Icons.delete,
                        color: AppColors.secondColor30,
                      ),
                    ),
                  ],
                ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          // tileColor: Colors.red,
          leading: Image.network(
            "${APILinks.itemImages}/${cart.item.imageUrl!}",
            height: 100,
            width: 50,
          ),
          title: Text(
            cart.item.itemsName!,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }
}
