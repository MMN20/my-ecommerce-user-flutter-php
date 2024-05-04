import 'package:dartz/dartz.dart';
import 'package:my_eccommerce_user/api_links.dart';
import 'package:my_eccommerce_user/core/class/crud.dart';
import 'package:my_eccommerce_user/core/request_status.dart';

class ItemsData {
  static Future<dynamic> getItems(
      String catid, String selectedSubCats, String userid) async {
    Either<RequestStatus, Map<dynamic, dynamic>> response = await CRUD.post(
        APILinks.itemsPageData,
        {"catid": catid, 'subcats': selectedSubCats, "userid": userid});
    return response.fold((l) => l, (r) => r);
  }

  // for the ItemsPage
  static Future<dynamic> getSearchedItems(
      String catid, String userid, String word) async {
    Either<RequestStatus, Map<dynamic, dynamic>> response = await CRUD.post(
        APILinks.searchedItems,
        {"catid": catid, 'subcats': "all", "userid": userid, 'word': word});
    return response.fold((l) => l, (r) => r);
  }

  static Future<dynamic> likeUnlike(String userid, String itemid) async {
    Either<RequestStatus, Map<dynamic, dynamic>> response = await CRUD
        .post(APILinks.likeUnlike, {"userid": userid, 'itemid': itemid});
    return response.fold((l) => l, (r) => r);
  }
}
