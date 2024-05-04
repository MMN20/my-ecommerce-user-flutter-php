class APILinks {
  // add the link of your server here
  static const String _server = "https://example.com/myecommerce/user";

  static const String categoryImages =
      "https://mustafa2000.com/myecommerce/upload/categories";
  static const String itemImages =
      "https://mustafa2000.com/myecommerce/upload/items";

  static const String promotionImages =
      "https://mustafa2000.com/myecommerce/upload/promotions";
  // Auth
  static const String signUp = "$_server/auth/signup.php";
  static const String verifyCode = "$_server/auth/verifycode.php";
  static const String verifyCodeResetPassword =
      "$_server/auth/verifycodeResetPassword.php";
  static const String resendCode = "$_server/auth/resend.php";
  static const String login = "$_server/auth/login.php";
  static const String resetPassword = "$_server/auth/resetpassword.php";
  static const String updateToken = "$_server/auth/update_token.php";

  // HomePage
  static const String homePageData = "$_server/data/home/homeData.php";
  // Items
  static const String itemsPageData = "$_server/data/getallitems.php";
  static const String likeUnlike = "$_server/data/like_unlike.php";
  static const String itemDetails = "$_server/data/item_details.php";
  static const String favoriteItems = "$_server/data/get_favorite_items.php";
  static const String searchedItems = "$_server/data/searched_items.php";

  // reviews
  static const String addReview = "$_server/data/reviews/add_review.php";
  static const String updateReview = "$_server/data/reviews/update_review.php";
  static const String deleteReview = "$_server/data/reviews/delete_review.php";
  static const String allReviews = "$_server/data/reviews/all_reviews.php";
  // Addresses
  static const String allAddresses =
      "$_server/data/settings/get_all_addresses.php";
  static const String addAddress = "$_server/data/settings/add_address.php";
  static const String deleteAddress =
      "$_server/data/settings/delete_address.php";

  // Cart
  static const String addToCart = "$_server/data/cart/add_to_cart.php";
  static const String deleteFromCart =
      "$_server/data/cart/delete_from_cart.php";
  static const String getAllCarts = "$_server/data/cart/get_all_items.php";
  static const String updateCartAmount =
      "$_server/data/cart/update_cart_amount.php";

  // Notifications
  static const String allNotifications =
      "$_server/data/notifications/all_notifications.php";

  // Coupon
  static const String checkCoupon = "$_server/data/coupon.php";

  //orders
  static const String addNewOrder = "$_server/data/orders/add_new_order.php";
  static const String getAllOrders = "$_server/data/orders/get_all_orders.php";
  static const String getArchivedOrders =
      "$_server/data/orders/archived_orders.php";
  static const String deleteOrder = "$_server/data/orders/delete_order.php";
  static const String getOrderItems =
      "$_server/data/orders/get_order_items.php";
}
