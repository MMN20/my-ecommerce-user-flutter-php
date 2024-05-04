import 'package:flutter/material.dart';
import 'package:my_eccommerce_user/core/utils/colors.dart';
import 'package:my_eccommerce_user/data/model/cart_model.dart';

/// user for increase and decrease the amount
class SmallButton extends StatelessWidget {
  const SmallButton(
      {super.key,
      required this.cart,
      required this.onTap,
      required this.child});
  final CartModel cart;
  final void Function() onTap;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: AppColors.thirdColor10,
      ),
      child: InkWell(
        onTap: onTap,
        child: child,
      ),
    );
  }
}
