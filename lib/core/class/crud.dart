import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:my_eccommerce_user/core/functions/check_intenet_connection.dart';
import 'package:my_eccommerce_user/core/request_status.dart';
import 'package:http/http.dart' as http;

class CRUD {
  static Future<Either<RequestStatus, Map>> post(
      String url, Map<String, String> data) async {
    if (await checkInternet()) {
      try {
        http.Response response = await http.post(Uri.parse(url), body: data);
        // connected to the server and everything is ok
        if (response.statusCode == 200 || response.statusCode == 201) {
          return Right(jsonDecode(response.body));
        }
        // connected but there is an exception in the endpoint code
        else {
          return const Left(RequestStatus.serverException);
        }
      } catch (e) {
        // have internet connection but failed to connect to the server
        return const Left(RequestStatus.serverError);
      }
    } else {
      // if you don't have internet connection
      return const Left(RequestStatus.internetConnectionError);
    }
  }
}
