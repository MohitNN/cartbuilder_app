import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mint_bird_app/main.dart';
import 'package:mint_bird_app/screens/auth/models/user_detail_model.dart';
import 'package:mint_bird_app/utils/api_utils.dart';

getUserDetails() async {
  var response = await http
      .post(Uri.parse(APIUtils.baseUrl + APIUtils.getUserDetail), headers: {
    "Authorization": "Bearer ${authController.userToken.value}",
  });
  Map<String, dynamic> decodedData = jsonDecode(response.body);
  if (decodedData["code"] == 200) {
    authController.userDetailModel.value =
        UserDetailModel.fromJson(decodedData);
  }
}
