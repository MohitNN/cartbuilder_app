import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mint_bird_app/main.dart';
import 'package:mint_bird_app/utils/api_utils.dart';
import 'package:mint_bird_app/widgets/get_toast.dart';

updatePaymentStatusService({
  String productId = '',
  String id = '',
  String type = '',
}) async {
  var response = await http.post(
      Uri.parse(APIUtils.baseUrl + APIUtils.updatePaymentStatus),
      headers: {
        "Authorization": "Bearer ${authController.userToken.value}",
      },
      body: {
        'id': id,
        'product_id': productId,
        'type': type,
      });
  Map<String, dynamic> decodedData = jsonDecode(response.body);
  if (response.statusCode == 200) {
    if (decodedData["status"] == 'Success') {
      getToast(msg: "Status Update Successfully");
      return true;
    } else {
      getToast(msg: "Something went wrong");
      return false;
    }
  } else {
    getToast(msg: decodedData["response"] ?? decodedData["message"]);
    return false;
  }
}
