class PromotionModel {
  int? promotionsId;
  String? promotionsTitle;
  String? promotionsBody;
  String? promotionsImageUrl;

  PromotionModel(
      {this.promotionsId,
      this.promotionsTitle,
      this.promotionsBody,
      this.promotionsImageUrl});

  PromotionModel.fromJson(Map<String, dynamic> json) {
    promotionsId = json['promotions_id'];
    promotionsTitle = json['promotions_title'];
    promotionsBody = json['promotions_body'];
    promotionsImageUrl = json['promotions_imageUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['promotions_id'] = promotionsId;
    data['promotions_title'] = promotionsTitle;
    data['promotions_body'] = promotionsBody;
    data['promotions_imageUrl'] = promotionsImageUrl;
    return data;
  }
}
