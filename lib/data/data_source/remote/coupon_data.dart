import 'package:dartz/dartz.dart';
import 'package:my_eccommerce_user/api_links.dart';
import 'package:my_eccommerce_user/core/class/crud.dart';
import 'package:my_eccommerce_user/core/request_status.dart';

class CouponData {
  static Future<dynamic> checkCoupon(String coupon) async {
    Either<RequestStatus, Map> response =
        await CRUD.post(APILinks.checkCoupon, {"coupon": coupon});
    return response.fold((l) => l, (r) => r);
  }
}
