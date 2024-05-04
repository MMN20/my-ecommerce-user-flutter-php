import 'package:dartz/dartz.dart';
import 'package:my_eccommerce_user/api_links.dart';
import 'package:my_eccommerce_user/core/class/crud.dart';
import 'package:my_eccommerce_user/core/request_status.dart';
import 'package:my_eccommerce_user/data/model/user.dart';
import 'package:my_eccommerce_user/view/widgets/request_status_view.dart';

class FavoriteData {
  static Future<dynamic> getFavoriteItems() async {
    Either<RequestStatus, Map> response = await CRUD.post(
        APILinks.favoriteItems,
        {"userid": UserModel.currentUser!.id.toString()});
    return response.fold((l) => l, (r) => r);
  }
}
