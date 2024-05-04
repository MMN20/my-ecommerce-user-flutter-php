import 'package:dartz/dartz.dart';
import 'package:my_eccommerce_user/api_links.dart';
import 'package:my_eccommerce_user/core/class/crud.dart';
import 'package:my_eccommerce_user/core/request_status.dart';
import 'package:my_eccommerce_user/data/model/user.dart';

class UserData {
  static Future<dynamic> signUp(Map<String, String> data) async {
    Either<RequestStatus, Map<dynamic, dynamic>> response =
        await CRUD.post(APILinks.signUp, data);
    return response.fold((l) => l, (r) => r);
  }

  static Future<dynamic> verifyCode(Map<String, String> data) async {
    Either<RequestStatus, Map<dynamic, dynamic>> response =
        await CRUD.post(APILinks.verifyCode, data);
    return response.fold((l) => l, (r) => r);
  }

  static Future<dynamic> verifyCodeResetPassword(
      Map<String, String> data) async {
    Either<RequestStatus, Map<dynamic, dynamic>> response =
        await CRUD.post(APILinks.verifyCodeResetPassword, data);
    return response.fold((l) => l, (r) => r);
  }

  static Future<dynamic> resendCode(Map<String, String> data) async {
    Either<RequestStatus, Map<dynamic, dynamic>> response =
        await CRUD.post(APILinks.resendCode, data);
    return response.fold((l) => l, (r) => r);
  }

  static Future<dynamic> resetPassword(Map<String, String> data) async {
    Either<RequestStatus, Map<dynamic, dynamic>> response =
        await CRUD.post(APILinks.resetPassword, data);
    return response.fold((l) => l, (r) => r);
  }

  static Future<dynamic> login(Map<String, String> data) async {
    Either<RequestStatus, Map<dynamic, dynamic>> response =
        await CRUD.post(APILinks.login, data);
    return response.fold((l) => l, (r) => r);
  }

  static Future<dynamic> updateToken(String token) async {
    Either<RequestStatus, Map<dynamic, dynamic>> response = await CRUD.post(
        APILinks.updateToken,
        {'token': token, "userid": UserModel.currentUser!.id.toString()});
    return response.fold((l) => l, (r) => r);
  }
}
