import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:my_eccommerce_user/core/middleware/my_middleware.dart';
import 'package:my_eccommerce_user/view/screens/auth/forgot_password.dart';
import 'package:my_eccommerce_user/view/screens/auth/login.dart';
import 'package:my_eccommerce_user/view/screens/auth/reset_password.dart';
import 'package:my_eccommerce_user/view/screens/auth/singup.dart';
import 'package:my_eccommerce_user/view/screens/auth/verify_code.dart';
import 'package:my_eccommerce_user/view/screens/cart_page.dart';
import 'package:my_eccommerce_user/view/screens/item_reviews.dart';
import 'package:my_eccommerce_user/view/screens/ordering_page.dart';
import 'package:my_eccommerce_user/view/screens/favorite_page.dart';
import 'package:my_eccommerce_user/view/screens/home_page.dart';
import 'package:my_eccommerce_user/view/screens/item_details_page.dart';
import 'package:my_eccommerce_user/view/screens/items_page.dart';
import 'package:my_eccommerce_user/view/screens/main_screens_window.dart';
import 'package:my_eccommerce_user/view/screens/onboarding.dart';
import 'package:my_eccommerce_user/view/screens/settings_pages/addresses_page/add_address_page.dart';
import 'package:my_eccommerce_user/view/screens/settings_pages/addresses_page/addresses_page.dart';
import 'package:my_eccommerce_user/view/screens/settings_pages/orders/archived_orders_page.dart';
import 'package:my_eccommerce_user/view/screens/settings_pages/orders/order_details_page.dart';
import 'package:my_eccommerce_user/view/screens/settings_pages/orders/orders_page.dart';
import 'package:my_eccommerce_user/view/screens/settings_pages/orders/tracking_page.dart';

class AppRoutes {
  static const String language = "/language";
  static const String onBoarding = "/onboarding";
  static const String login = "/login";
  static const String signUp = "/signup";
  static const String verifycode = "/verifycode";
  static const String homePage = "/homePage";
  static const String resetPassword = "/resetPassword";
  static const String forgetPassword = "/forgetPassword";
  static const String items = "/items";
  static const String mainScreen = "/mainScreen";
  static const String itemDetails = "/itemDetails";
  static const String itemReviews = "/allReviews";
  static const String favoritePage = "/favoritePage";
  static const String ordersPage = "/ordersPage";
  static const String addresses = "/addresses";
  static const String addAddress = "/addAddress";
  static const String cartPage = "/cartPage";
  static const String checkoutPage = "/checkoutPage";
  static const String orderDetailsPage = "/orderDetailsPage";
  static const String orderTrackingPage = "/orderTrackingPage";
  static const String archivedOrders = "/archivedOrders";
}

List<GetPage> pages = [
  GetPage(name: AppRoutes.mainScreen, page: () => const MainScreensWindow()),
  // GetPage(
  // name: "/", page: () => const Language(), middlewares: [MyMiddleWare()]),
  GetPage(
      name: "/", page: () => const OnBoarding(), middlewares: [MyMiddleWare()]),
  GetPage(name: AppRoutes.login, page: () => const LoginPage()),
  GetPage(name: AppRoutes.signUp, page: () => const SignUpPage()),
  GetPage(name: AppRoutes.verifycode, page: () => const VerifyCode()),
  GetPage(name: AppRoutes.homePage, page: () => const HomePage()),
  GetPage(name: AppRoutes.resetPassword, page: () => const ResetPassword()),
  GetPage(
      name: AppRoutes.forgetPassword, page: () => const ForgetPasswordPage()),
  GetPage(name: AppRoutes.items, page: () => const ItemsPage()),
  GetPage(name: AppRoutes.itemDetails, page: () => const ItemDetailsPage()),
  GetPage(name: AppRoutes.favoritePage, page: () => const FavoritePage()),
  GetPage(name: AppRoutes.addresses, page: () => const AddressesPage()),
  GetPage(name: AppRoutes.addAddress, page: () => const AddAddressPage()),
  GetPage(name: AppRoutes.cartPage, page: () => const CartPage()),
  GetPage(name: AppRoutes.checkoutPage, page: () => const OrderingPage()),
  GetPage(name: AppRoutes.ordersPage, page: () => const OrdersPage()),
  GetPage(
      name: AppRoutes.archivedOrders, page: () => const ArchivedOrdersPage()),
  GetPage(
      name: AppRoutes.orderTrackingPage, page: () => const OrderTrackingPage()),
  GetPage(
      name: AppRoutes.orderDetailsPage, page: () => const OrderDetailsPage()),
  GetPage(name: AppRoutes.itemReviews, page: () => const ItemReviewsPage()),

  //! uncomment when needed
  // GetPage(name: AppRoutes.aboutUs, page: () => const AddressesPage()),
  // GetPage(name: AppRoutes.contactUs, page: () => const AddressesPage()),
];
