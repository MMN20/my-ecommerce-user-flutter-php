class OrderModel {
  int? ordersId;
  int? ordersUsersid;
  int? ordersDeliveryid;
  int? ordersStatusid;
  int? ordersAddressid;
  int? ordersTypeid;
  double? ordersDeliveryprice;
  int? ordersCouponid;
  int? ordersRating;
  String? ordersRatingnote;
  int? ordersPaymentmethodid;
  String? ordersDatetime;
  double? fullPrice;
  String? orderStatusName;
  String? addressesName;
  String? ordersTypeName;
  int? isUsedCoupon;
  String? paymentMethodsName;
  double? priceAfterCoupon;
 

  OrderModel({
    this.ordersId,
    this.ordersUsersid,
    this.ordersDeliveryid,
    this.ordersStatusid,
    this.ordersAddressid,
    this.ordersTypeid,
    this.ordersDeliveryprice,
    this.ordersCouponid,
    this.ordersRating,
    this.ordersRatingnote,
    this.ordersPaymentmethodid,
    this.ordersDatetime,
    this.fullPrice,
    this.orderStatusName,
    this.addressesName,
    this.ordersTypeName,
    this.isUsedCoupon,
    this.paymentMethodsName,
    this.priceAfterCoupon,
    
  });

  OrderModel.fromJson(Map<String, dynamic> json) {
    ordersId = json['orders_id'];
    ordersUsersid = json['orders_usersid'];
    ordersDeliveryid = json['orders_deliveryid'];
    ordersStatusid = json['orders_statusid'];
    ordersAddressid = json['orders_addressid'];
    ordersTypeid = json['orders_typeid'];
    ordersDeliveryprice =
        double.tryParse(json['orders_deliveryprice'].toString());
    ordersCouponid = json['orders_couponid'];
    ordersRating = json['orders_rating'];
    ordersRatingnote = json['orders_ratingnote'];
    ordersPaymentmethodid = json['orders_paymentmethodid'];
    ordersDatetime = json['orders_datetime'];
    fullPrice = double.tryParse(json['fullPrice'].toString());
    orderStatusName = json['order_status_name'];
    addressesName = json['addresses_name'];
    ordersTypeName = json['orders_type_name'];
    isUsedCoupon = json['isUsedCoupon'];
    paymentMethodsName = json['payment_methods_name'];
    priceAfterCoupon = double.tryParse(json['priceAfterCoupon'].toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['orders_id'] = this.ordersId;
    data['orders_usersid'] = this.ordersUsersid;
    data['orders_deliveryid'] = this.ordersDeliveryid;
    data['orders_statusid'] = this.ordersStatusid;
    data['orders_addressid'] = this.ordersAddressid;
    data['orders_typeid'] = this.ordersTypeid;
    data['orders_deliveryprice'] = this.ordersDeliveryprice;
    data['orders_couponid'] = this.ordersCouponid;
    data['orders_rating'] = this.ordersRating;
    data['orders_ratingnote'] = this.ordersRatingnote;
    data['orders_paymentmethodid'] = this.ordersPaymentmethodid;
    data['orders_datetime'] = this.ordersDatetime;
    data['fullPrice'] = this.fullPrice;
    data['order_status_name'] = this.orderStatusName;
    data['addresses_name'] = this.addressesName;
    data['orders_type_name'] = this.ordersTypeName;
    data['isUsedCoupon'] = this.isUsedCoupon;
    data['payment_methods_name'] = this.paymentMethodsName;
    data['priceAfterCoupon'] = this.priceAfterCoupon;
    return data;
  }
}
