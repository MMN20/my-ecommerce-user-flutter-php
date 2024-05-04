import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_eccommerce_user/api_links.dart';
import 'package:my_eccommerce_user/controller/home_page_controller.dart';
import 'package:my_eccommerce_user/controller/items_page_controller.dart';
import 'package:my_eccommerce_user/core/functions/handle_request_data.dart';
import 'package:my_eccommerce_user/core/request_status.dart';
import 'package:my_eccommerce_user/data/data_source/remote/item_details_data.dart';
import 'package:my_eccommerce_user/data/model/image.dart';
import 'package:my_eccommerce_user/data/model/item_model.dart';
import 'package:my_eccommerce_user/data/model/review.dart';
import 'package:my_eccommerce_user/data/model/specifications.dart';
import 'package:my_eccommerce_user/routes.dart';
import 'package:my_eccommerce_user/view/widgets/item_details_page/delete_review_dialog.dart';
import 'package:my_eccommerce_user/view/widgets/item_details_page/rating_bottom_sheet.dart';

class ItemDetailsPageController extends GetxController {
  RequestStatus requestStatus = RequestStatus.none;

  List<Specification> specs = [];
  List<ImageModel> images = [];
  List<Review> reviews = [];
  List<ItemModel> suggestedItems = [];
  late ItemModel currentItem;
  Review? currentUserReview;
  List<Image> flutterImages = [];
  int selectedImageIndex = 0;
  late bool isAddedToCart;
  bool isBottomAppBarLoading = false;
  bool isAddingReviewLoading = false;
  bool isDeleteCurrentUserReviewVisible = false;

  bool isDeleteCurrentUserReviewDialogLoading = false;

  /// this is for Get.back() to avoid exiting the details page by checking if the BottomSheet not shown then dont call Get.back()
  bool isAddingReviewSheetShown = false;

  int choosedRating = 0;
  TextEditingController commentController = TextEditingController();

  bool isComeFromItemDetailsPage = false;

  Future<void> getAllData() async {
    requestStatus = RequestStatus.loading;
    update();
    dynamic response =
        await ItemDetailsData.getAllData(currentItem.itemId!.toString());
    requestStatus = hanldeRequestData(response);
    if (requestStatus == RequestStatus.success) {
      List responseData = response['data']['specs'];

      specs = responseData.map((e) => Specification.fromJson(e)).toList();
      responseData = response['data']['images'];
      images = responseData.map((e) => ImageModel.fromJson(e)).toList();
      responseData = response['data']['reviews'];
      reviews = responseData.map((e) => Review.fromJson(e)).toList();
      currentUserReview = response['data']['userReview'] == "none"
          ? null
          : Review.fromJson(response['data']['userReview']);
    }
    for (ImageModel imageModel in images) {
      flutterImages
          .add(Image.network("${APILinks.itemImages}/${imageModel.imageURL}"));
    }
    update();
  }

  void changeSelectedImageIndex(int index) {
    selectedImageIndex = index;
    update();
  }

  void updateItemsListPage() {
    if (isComeFromItemDetailsPage) {
      final controller = Get.find<ItemsPageController>();
      controller.update();
    }
  }

  Future<void> addToCart() async {
    isBottomAppBarLoading = true;
    update();

    dynamic response = await currentItem.addToCart();
    response = hanldeRequestData(response);
    if (response == RequestStatus.success) {
      currentItem.cartAmount = 1;
      isAddedToCart = true;
      updateItemsListPage();
    }
    isBottomAppBarLoading = false;
    update();
  }

  Future<void> likeUnlike() async {
    currentItem.likeUnlike();
    update();
    updateItemsListPage();
    refreshHomePageOffers(currentItem);
  }

  void refreshHomePageOffers(ItemModel itemModel) {
    final controller = Get.find<HomePageController>();
    for (var item in controller.offers) {
      if (item.itemsId == itemModel.itemsId) {
        item.isFavorite = itemModel.isFavorite;
        break;
      }
    }
    controller.update();
  }

  void deletingFromCartUIUpdates() {
    isAddedToCart = false;
    currentItem.cartAmount = 0;
  }

  Future<void> onDeleteFromCart() async {
    isBottomAppBarLoading = true;
    update();
    dynamic response = await currentItem.deleteFromCart();
    response = hanldeRequestData(response);
    if (response == RequestStatus.success) {
      isAddedToCart = false;
      currentItem.cartAmount = 0;
      updateItemsListPage();
    }
    isBottomAppBarLoading = false;
    update();
  }

  //! complete the review sending

// for Adding the ecurrentUserReview
  void showRatingBottomSheetForAdding() {
    isAddingReviewSheetShown = true;
    Get.bottomSheet(
      BottomSheet(
        // enableDrag: true,
        onClosing: () {},
        builder: (context) {
          return GetBuilder(
              init: this,
              builder: (controller) {
                return WillPopScope(
                  onWillPop: () {
                    isAddingReviewSheetShown = false;

                    return Future.value(true);
                  },
                  child: RatingBottomSheet(
                    choosedRating: choosedRating,
                    commentController: commentController,
                    isAddingReviewLoading: isAddingReviewLoading,
                    onStarTap: (rating) {
                      choosedRating = rating;
                      update();
                    },
                    onSendTap: () => addTheReview(),
                  ),
                );
              });
        },
      ),
    );
  }

  // for updating the ecurrentUserReview
  void showRatingBottomSheetForUpdating() {
    commentController.text = currentUserReview!.comment!;
    choosedRating = currentUserReview!.rating!;
    isAddingReviewSheetShown = true;
    Get.bottomSheet(
      BottomSheet(
        // enableDrag: true,
        onClosing: () {},
        builder: (context) {
          return GetBuilder(
              init: this,
              builder: (controller) {
                return WillPopScope(
                  onWillPop: () {
                    isAddingReviewSheetShown = false;
                    return Future.value(true);
                  },
                  child: RatingBottomSheet(
                    choosedRating: choosedRating,
                    commentController: commentController,
                    isAddingReviewLoading: isAddingReviewLoading,
                    onStarTap: (rating) {
                      choosedRating = rating;
                      update();
                    },
                    onSendTap: () => updateTheReview(),
                  ),
                );
              });
        },
      ),
    );
  }

  Future<void> updateTheReview() async {
    if (choosedRating > 0) {
      isAddingReviewLoading = true;
      update();
      dynamic response = await currentItem.updateAReview(currentItem.itemsId!,
          currentUserReview!.id!, choosedRating, commentController.text);
      RequestStatus requestStatus = hanldeRequestData(response);
      if (requestStatus == RequestStatus.success) {
        currentUserReview!.rating = choosedRating;
        currentUserReview!.comment = commentController.text;

        double newRating = double.parse(response['newRating'].toString());

        currentItem.rating = newRating;
        if (isAddingReviewSheetShown) {
          Get.back();
        }
        Get.snackbar(
          "Success",
          "The review was updated successfully!",
        );
        updateItemsListPage();
      }
      isAddingReviewLoading = false;
      update();
    }
  }

  Future<void> addTheReview() async {
    if (choosedRating > 0) {
      Review review = Review(
        itemID: currentItem.itemsId,
        rating: choosedRating,
        comment: commentController.text,
      );
      isAddingReviewLoading = true;
      update();
      dynamic response = await currentItem.addAReview(review);
      RequestStatus requestStatus = hanldeRequestData(response);
      if (requestStatus == RequestStatus.success) {
        review.id = response['newID'];
        currentUserReview = review;
        double newRating = double.parse(response['newRating'].toString());
        currentItem.raters = currentItem.raters! + 1;
        currentItem.rating = double.parse(response['newRating'].toString());
        if (isAddingReviewSheetShown) {
          Get.back();
        }

        updateItemsListPage();
      }
      isAddingReviewLoading = false;
      update();
    }
  }

  void showDeleteCurrentUserReviewDialog() {
    isDeleteCurrentUserReviewVisible = true;
    Get.dialog(
      GetBuilder(
          init: this,
          builder: (controller) {
            return WillPopScope(
              onWillPop: () {
                isDeleteCurrentUserReviewVisible = false;
                return Future.value(true);
              },
              child: DeleteReviewDialog(),
            );
          }),
    );
  }

  Future<void> deleteCurrentUserReview() async {
    isDeleteCurrentUserReviewDialogLoading = true;
    update();
    dynamic response = await currentItem.deleteReview(
        currentUserReview!.id!, currentUserReview!.itemID!);
    RequestStatus requestStatus = hanldeRequestData(response);
    if (requestStatus == RequestStatus.success) {
      currentUserReview = null;
      currentItem.raters = currentItem.raters! - 1;
      currentItem.rating = double.parse(response['newRating'].toString());
      updateItemsListPage();
      if (isDeleteCurrentUserReviewVisible) {
        Get.back();
      }
    }
    isDeleteCurrentUserReviewDialogLoading = false;
    update();
  }

  void goToCartPage() {
    Get.toNamed(AppRoutes.cartPage, arguments: {'isItemDetails': true});
  }

  void goToReviewsPage() {
    Get.toNamed(AppRoutes.itemReviews, arguments: {'item': currentItem});
  }

  @override
  void onInit() {
    currentItem = Get.arguments['item'];
    isAddedToCart = currentItem.cartAmount! > 0;
    isComeFromItemDetailsPage = Get.arguments['isItemsPage'] ?? false;
    getAllData();
    super.onInit();
  }
}
