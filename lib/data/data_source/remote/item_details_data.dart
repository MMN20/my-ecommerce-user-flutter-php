import 'package:dartz/dartz.dart';
import 'package:my_eccommerce_user/api_links.dart';
import 'package:my_eccommerce_user/core/class/crud.dart';
import 'package:my_eccommerce_user/core/request_status.dart';
import 'package:my_eccommerce_user/data/model/user.dart';

class ItemDetailsData {
  static Future<dynamic> getAllData(String itemid) async {
    Either<RequestStatus, Map> reponse = await CRUD.post(APILinks.itemDetails,
        {"itemid": itemid, "userid": UserModel.currentUser!.id.toString()});
    return reponse.fold((l) => l, (r) => r);
  }

  static Future<dynamic> addToCart(String itemid) async {
    Either<RequestStatus, Map> reponse = await CRUD.post(APILinks.addToCart, {
      "itemid": itemid,
      "userid": UserModel.currentUser!.id.toString(),
      "amount": "1"
    });
    return reponse.fold((l) => l, (r) => r);
  }

  static Future<dynamic> deleteFromCart(String itemid) async {
    Either<RequestStatus, Map> reponse =
        await CRUD.post(APILinks.deleteFromCart, {
      "itemid": itemid,
      "userid": UserModel.currentUser!.id.toString(),
    });
    return reponse.fold((l) => l, (r) => r);
  }

  static Future<dynamic> addAReview(
      String itemid, String rating, String comment) async {
    Either<RequestStatus, Map> reponse = await CRUD.post(APILinks.addReview, {
      "itemid": itemid,
      "userid": UserModel.currentUser!.id.toString(),
      "rating": rating,
      "comment": comment
    });
    return reponse.fold((l) => l, (r) => r);
  }

  static Future<dynamic> updateAReview(
      String itemid, String reviewid, String rating, String comment) async {
    Either<RequestStatus, Map> reponse = await CRUD.post(
        APILinks.updateReview, {
      "reviewid": reviewid,
      "rating": rating,
      "comment": comment,
      "itemid": itemid
    });
    return reponse.fold((l) => l, (r) => r);
  }

  static Future<dynamic> deleteAReview(String reviewid, String itemid) async {
    Either<RequestStatus, Map> reponse =
        await CRUD.post(APILinks.deleteReview, {
      "reviewid": reviewid,
      "itemid": itemid,
    });
    return reponse.fold((l) => l, (r) => r);
  }

  static Future<dynamic> getAllReviews(String itemid) async {
    Either<RequestStatus, Map> reponse = await CRUD.post(APILinks.allReviews, {
      "itemid": itemid,
    });
    return reponse.fold((l) => l, (r) => r);
  }
}
