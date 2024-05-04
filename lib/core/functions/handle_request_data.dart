import 'package:my_eccommerce_user/core/request_status.dart';

RequestStatus hanldeRequestData(dynamic response) {
  if (response is! RequestStatus) {
    return RequestStatus.success;
  } else {
    return response;
  }
}
