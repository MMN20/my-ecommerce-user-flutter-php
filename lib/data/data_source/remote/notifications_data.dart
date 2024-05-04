import 'package:dartz/dartz.dart';
import 'package:my_eccommerce_user/api_links.dart';
import 'package:my_eccommerce_user/core/class/crud.dart';
import 'package:my_eccommerce_user/core/request_status.dart';
import 'package:my_eccommerce_user/data/model/user.dart';

class NotificationsData {
  static Future<dynamic> getAllNotifications(String currentIndex) async {
    Either<RequestStatus, Map<dynamic, dynamic>> response = await CRUD.post(
        APILinks.allNotifications, {
      'userid': UserModel.currentUser!.id.toString(),
      'id': currentIndex.toString()
    });
    return response.fold((l) => l, (r) => r);
  }
}
