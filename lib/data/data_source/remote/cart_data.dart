import 'package:dartz/dartz.dart';
import 'package:my_eccommerce_user/api_links.dart';
import 'package:my_eccommerce_user/core/class/crud.dart';
import 'package:my_eccommerce_user/core/request_status.dart';
import 'package:my_eccommerce_user/data/model/user.dart';

class CartData {
  static Future<dynamic> getAllCarts() async {
    Either<RequestStatus, Map> response = await CRUD.post(
        APILinks.getAllCarts, {'userid': UserModel.currentUser!.id.toString()});
    return response.fold((l) => l, (r) => r);
  }

  static Future<dynamic> updateCartAmount(
      String cartID, String newAmount) async {
    Either<RequestStatus, Map> response = await CRUD.post(
        APILinks.updateCartAmount, {'cartid': cartID, 'amount': newAmount});
    return response.fold((l) => l, (r) => r);
  }
}
