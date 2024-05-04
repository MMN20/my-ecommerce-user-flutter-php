import 'package:my_eccommerce_user/data/data_source/remote/item_details_data.dart';
import 'package:my_eccommerce_user/data/data_source/remote/items_page_data.dart';
import 'package:my_eccommerce_user/data/model/review.dart';
import 'package:my_eccommerce_user/data/model/user.dart';

class ItemModel {
  int? itemsId;
  String? itemsName;
  String? itemsDesc;
  double? itemsPrice;
  int? itemsQty;
  int? isActive;
  int? discount;
  int? itemsSubcatId;
  int? brandId;
  int? subcatId;
  String? subcatName;
  String? subcatDesc;
  String? subcatImageUrl;
  int? catId;
  int? id;
  String? imageUrl;
  int? itemId;
  double? rating;
  int? brandsId;
  String? brandsName;
  double? priceAfterDiscount;
  bool? isFavorite;
  int? raters;
  // for certain pages
  int? cartAmount;
  // for OrderDetails page only
  int? orderedAmount;

  ItemModel(
      {this.itemsId,
      this.itemsName,
      this.itemsDesc,
      this.itemsPrice,
      this.itemsQty,
      this.isActive,
      this.discount,
      this.itemsSubcatId,
      this.brandId,
      this.subcatId,
      this.subcatName,
      this.subcatDesc,
      this.subcatImageUrl,
      this.catId,
      this.id,
      this.imageUrl,
      this.itemId,
      this.rating,
      this.brandsId,
      this.brandsName,
      this.priceAfterDiscount,
      this.isFavorite,
      this.raters,
      this.cartAmount,
      this.orderedAmount});

  ItemModel.fromJson(Map<String, dynamic> json) {
    itemsId = json['items_id'];
    itemsName = json['items_name'];
    itemsDesc = json['items_desc'];
    itemsPrice = json['items_price'].toDouble();
    itemsQty = json['items_qty'];
    isActive = json['isActive'];
    discount = json['discount'];
    itemsSubcatId = json['items_subcat_id'];
    brandId = json['brand_id'];
    subcatId = json['subcat_id'];
    subcatName = json['subcat_name'];
    subcatDesc = json['subcat_desc'];
    subcatImageUrl = json['subcat_imageUrl'];
    catId = json['cat_id'];
    id = json['id'];
    imageUrl = json['imageUrl'];
    itemId = json['item_id'];
    rating = double.tryParse(json['rating'].toString()) ?? 0;
    brandsId = json['brands_id'];
    brandsName = json['brands_name'];
    priceAfterDiscount = double.parse(json["priceAfterDiscount"].toString());
    isFavorite = json['favorite'] == 1;
    raters = json['raters'] ?? 0;
    cartAmount = json['cart_amount'];
    orderedAmount = json['ordered_amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['items_id'] = this.itemsId;
    data['items_name'] = this.itemsName;
    data['items_desc'] = this.itemsDesc;
    data['items_price'] = this.itemsPrice;
    data['items_qty'] = this.itemsQty;
    data['isActive'] = this.isActive;
    data['discount'] = this.discount;
    data['items_subcat_id'] = this.itemsSubcatId;
    data['brand_id'] = this.brandId;
    data['subcat_id'] = this.subcatId;
    data['subcat_name'] = this.subcatName;
    data['subcat_desc'] = this.subcatDesc;
    data['subcat_imageUrl'] = this.subcatImageUrl;
    data['cat_id'] = this.catId;
    data['id'] = this.id;
    data['imageUrl'] = this.imageUrl;
    data['item_id'] = this.itemId;
    data['rating'] = this.rating;
    data['brands_id'] = this.brandsId;
    data['brands_name'] = this.brandsName;
    data['priceAfterDiscount'] = this.priceAfterDiscount;
    data['favorite'] = isFavorite;
    data['rators'] = raters;
    data['cart_amount'] = cartAmount;
    data['ordered_amount'] = orderedAmount;

    return data;
  }

  Future<void> likeUnlike() async {
    isFavorite = !isFavorite!;
    await ItemsData.likeUnlike(
        UserModel.currentUser!.id.toString(), itemId.toString());
  }

  //! write add to cart function to call it from the controller
  Future<dynamic> addToCart() async {
    return await ItemDetailsData.addToCart(itemsId.toString());
  }

  Future<dynamic> deleteFromCart() async {
    return await ItemDetailsData.deleteFromCart(itemsId.toString());
  }

  Future<dynamic> addAReview(Review review) async {
    return await ItemDetailsData.addAReview(
        review.itemID.toString(), review.rating.toString(), review.comment!);
  }

  Future<dynamic> updateAReview(
      int itemid, int reviewid, int rating, String comment) async {
    return await ItemDetailsData.updateAReview(
        itemid.toString(), reviewid.toString(), rating.toString(), comment);
  }

  Future<dynamic> deleteReview(int reviewid, int itemid) async {
    return await ItemDetailsData.deleteAReview(
        reviewid.toString(), itemid.toString());
  }
}
