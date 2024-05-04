import 'package:get/get.dart';
import 'package:my_eccommerce_user/core/functions/handle_request_data.dart';
import 'package:my_eccommerce_user/core/request_status.dart';
import 'package:my_eccommerce_user/data/data_source/remote/item_details_data.dart';
import 'package:my_eccommerce_user/data/data_source/remote/items_page_data.dart';
import 'package:my_eccommerce_user/data/model/item_model.dart';
import 'package:my_eccommerce_user/data/model/review.dart';

class ItemReviewsPageController extends GetxController {
  List<Review> reviews = [];
  late ItemModel currentItem;
  RequestStatus requestStatus = RequestStatus.none;

  Future<void> getAllReviews() async {
    requestStatus = RequestStatus.loading;
    update();
    //! get all reviews
    dynamic response =
        await ItemDetailsData.getAllReviews(currentItem.itemsId!.toString());
    requestStatus = hanldeRequestData(response);
    if (requestStatus == RequestStatus.success) {
      if (response['status'] == 'success') {
        List responseData = response['data'];
        reviews = responseData.map((e) => Review.fromJson(e)).toList();
      } else {
        requestStatus = RequestStatus.empty;
      }
    }
    update();
  }

  @override
  void onInit() {
    currentItem = Get.arguments['item'];
    getAllReviews();
    super.onInit();
  }
}
