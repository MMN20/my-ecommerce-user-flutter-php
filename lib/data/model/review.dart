class Review {
  int? id;
  int? rating;
  int? userID;
  int? itemID;
  String? comment;

  Review({
    this.id,
    this.rating,
    this.userID,
    this.itemID,
    this.comment,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      id: json['reviews_id'],
      rating: json['reviews_rating'],
      userID: json['user_id'],
      itemID: json['item_id'],
      comment: json['review_comment'],
    );
  }
}
