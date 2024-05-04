import 'package:dartz/dartz.dart';
import 'package:my_eccommerce_user/api_links.dart';
import 'package:my_eccommerce_user/core/class/crud.dart';
import 'package:my_eccommerce_user/core/request_status.dart';
import 'package:my_eccommerce_user/data/model/user.dart';

class HomePageData {
  static Future<dynamic> homePageData() async {
    Either<RequestStatus, Map<dynamic, dynamic>> response = await CRUD.post(
        APILinks.homePageData,
        {"userid": UserModel.currentUser!.id.toString()});
    return response.fold((l) => l, (r) => r);
  }
}
