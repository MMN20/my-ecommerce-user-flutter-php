import 'package:flutter/material.dart';
import 'package:my_eccommerce_user/data/model/order_model.dart';
import 'package:my_eccommerce_user/view/widgets/general_button.dart';
import 'package:my_eccommerce_user/view/widgets/settings_page/orders_page/order_data.dart';

class OrderCard extends StatelessWidget {
  const OrderCard(
      {super.key,
      this.valueStyle =
          const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
      required this.values,
      required this.color,
      required this.orderModel,
      required this.onDeleteTap,
      required this.onDetailsTap});
  final List<OrderValue> values;
  final TextStyle valueStyle;
  final OrderModel orderModel;
  final Color color;
  final void Function() onDeleteTap;
  final void Function() onDetailsTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onDetailsTap,
      child: Card(
        color: color,
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              ...List.generate(
                values.length,
                ((index) {
                  return Column(
                    children: [
                      OrderData(
                        name: "${values[index].name}",
                        value: values[index].value,
                      ),
                      if (index + 1 < values.length)
                        const Divider(thickness: 0.2)
                    ],
                  );
                }),
              ),
              const SizedBox(height: 13),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GeneralButton(
                      onPressed: onDetailsTap,
                      child: const Padding(
                        padding: EdgeInsets.all(3.0),
                        child: Text("Details"),
                      )),
                  if (orderModel.orderStatusName == "Pending")
                    GeneralButton(
                        backgroundColor: Colors.red,
                        onPressed: onDeleteTap,
                        child: const Padding(
                          padding: EdgeInsets.all(3.0),
                          child: Text("Delete"),
                        )),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class OrderValue {
  final String name;
  final String value;

  const OrderValue({required this.name, required this.value});
}
