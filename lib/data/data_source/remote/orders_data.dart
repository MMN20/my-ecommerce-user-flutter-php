import 'package:dartz/dartz.dart';
import 'package:my_eccommerce_user/api_links.dart';
import 'package:my_eccommerce_user/core/class/crud.dart';
import 'package:my_eccommerce_user/core/request_status.dart';
import 'package:my_eccommerce_user/data/model/user.dart';

class OrdersData {
  static Future<dynamic> addNewOrder(String addressid, String orderTypeID,
      String deliveryPrice, String couponID, String paymentMethod) async {
    Either<RequestStatus, Map> response =
        await CRUD.post(APILinks.addNewOrder, {
      'userid': UserModel.currentUser!.id.toString(),
      "addressid": addressid,
      "orderTypeID": orderTypeID,
      "deliveryPrice": deliveryPrice,
      "couponID": couponID,
      "paymentMethod": paymentMethod
    });
    return response.fold((l) => l, (r) => r);
  }

  static Future<dynamic> getAllOrders() async {
    Either<RequestStatus, Map> response =
        await CRUD.post(APILinks.getAllOrders, {
      'userid': UserModel.currentUser!.id.toString(),
    });
    return response.fold((l) => l, (r) => r);
  }

  static Future<dynamic> getArchivedOrders() async {
    Either<RequestStatus, Map> response =
        await CRUD.post(APILinks.getArchivedOrders, {
      'userid': UserModel.currentUser!.id.toString(),
    });
    return response.fold((l) => l, (r) => r);
  }

  static Future<dynamic> deleteOrder(String orderID) async {
    Either<RequestStatus, Map> response =
        await CRUD.post(APILinks.deleteOrder, {"orderid": orderID});
    return response.fold((l) => l, (r) => r);
  }

  static Future<dynamic> getOrderItems(String orderID) async {
    Either<RequestStatus, Map> response = await CRUD.post(
        APILinks.getOrderItems,
        {"orderid": orderID, "userid": UserModel.currentUser!.id.toString()});
    return response.fold((l) => l, (r) => r);
  }
}
