import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_eccommerce_user/core/utils/colors.dart';

class PaymentMethodItem extends StatelessWidget {
  const PaymentMethodItem(
      {super.key,
      required this.name,
      required this.isSelected,
      required this.assetName,
      required this.onTap});
  final String name;
  final bool isSelected;
  final String assetName;
  final void Function() onTap;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        splashFactory: NoSplash.splashFactory,
        onTap: onTap,
        child: Card(
          elevation: 5,
          color: isSelected ? AppColors.thirdColor10 : null,
          child: SizedBox(
            height: Get.height * 0.15,
            child: Column(
              children: [
                Expanded(
                  child: Image.asset(
                    assetName,
                    fit: BoxFit.cover,
                  ),
                ),
                Text(
                  name,
                  style: TextStyle(color: isSelected ? Colors.white : null),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
