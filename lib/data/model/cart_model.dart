import 'package:my_eccommerce_user/data/model/item_model.dart';

class CartModel {
  int amount;
  int cartID;
  ItemModel item;
  CartModel({required this.amount, required this.item, required this.cartID});

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
        amount: json['cart_amount'],
        item: ItemModel.fromJson(json),
        cartID: json['cart_id']);
  }
}
