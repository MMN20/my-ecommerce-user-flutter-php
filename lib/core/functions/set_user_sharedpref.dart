import 'package:my_eccommerce_user/data/model/user.dart';
import 'package:my_eccommerce_user/main.dart';

Future<void> saveUserSharedPrefs(
    String id, String email, String username) async {
  await sharedPreferences.setString("id", id);
  await sharedPreferences.setString("email", email);
  await sharedPreferences.setString("username", username);

  UserModel.currentUser = UserModel(
      id: int.parse(id), email: email, password: "", username: username);
}
