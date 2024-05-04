import 'package:dartz/dartz.dart';
import 'package:my_eccommerce_user/api_links.dart';
import 'package:my_eccommerce_user/core/class/crud.dart';
import 'package:my_eccommerce_user/core/request_status.dart';
import 'package:my_eccommerce_user/data/model/user.dart';

class AddressesData {
  static Future<dynamic> getAllAddresses() async {
    final response = await CRUD.post(APILinks.allAddresses,
        {'userid': UserModel.currentUser!.id.toString()});
    return response.fold((l) => l, (r) => r);
  }

  static Future<dynamic> addAddress(
      String name, String desc, String lat, String long) async {
    final response = await CRUD.post(APILinks.addAddress, {
      'userid': UserModel.currentUser!.id.toString(),
      'name': name,
      'desc': desc,
      "lat": lat,
      "long": long,
    });
    return response.fold((l) => l, (r) => r);
  }

  static Future<dynamic> deleteAddress(String addressid) async {
    final response = await CRUD.post(APILinks.deleteAddress, {
      'id': addressid,
    });
    return response.fold((l) => l, (r) => r);
  }
}
