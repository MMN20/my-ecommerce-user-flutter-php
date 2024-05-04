import 'package:my_eccommerce_user/core/request_status.dart';
import 'package:my_eccommerce_user/data/data_source/remote/user_data.dart';
import 'package:my_eccommerce_user/view/widgets/request_status_view.dart';

class UserModel {
  int id;
  String username;
  String email;
  String password;
  bool? isApproved;

  UserModel(
      {required this.id,
      required this.email,
      required this.password,
      required this.username});

  factory UserModel.fromJson(Map data) {
    return UserModel(
        id: data['users_id'],
        email: data['users_email'],
        password: data['users_password'],
        username: data['users_username']);
  }

  // used to send it as a POST body
  Map<String, String> toMap() {
    return {
      // this is not necessary for now but thats ok
      'users_id': id.toString(),
      'email': email,
      'password': password,
      'username': username
    };
  }

  static UserModel? currentUser;

  // returns true if successful and RequestStatus if failed
  static Future<dynamic> signUp(UserModel user) async {
    dynamic response = await UserData.signUp(user.toMap());
    if (response is! RequestStatus && response['id'] != null) {
      user.id = int.parse(response['id']);
    }
    return response;
  }

  Future<dynamic> verifyCode(String code) async {
    dynamic response =
        await UserData.verifyCode({"code": code, "email": email});
    return response;
  }

  static Future<dynamic> verifyCodeForResetingPassword(
      String code, String email) async {
    dynamic response =
        await UserData.verifyCodeResetPassword({"code": code, "email": email});
    return response;
  }

  Future<dynamic> resendCode() async {
    dynamic response = await UserData.resendCode({"email": email});
    return response;
  }

  static Future<dynamic> resendVerifyCode(String email) async {
    dynamic response = await UserData.resendCode({"email": email});
    return response;
  }

  static Future<dynamic> sendVerificationCodeForPasswordUpdate(
      String email) async {
    dynamic response = await UserData.resendCode({"email": email});
    return response;
  }

  static Future<dynamic> resetPassword(String email, String password) async {
    dynamic response =
        await UserData.resetPassword({"email": email, "password": password});
    return response;
  }

  Future<dynamic> login() async {
    dynamic response =
        await UserData.login({"email": email, "password": password});
    if (response is! RequestStatus && response['status'] == "success") {
      isApproved = response['data']['users_approved'] == 1;
      id = response['data']['users_id'];
      username = response['data']['users_username'];
    }
    return response;
  }
}
