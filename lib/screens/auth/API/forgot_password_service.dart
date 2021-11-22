import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mint_bird_app/utils/api_utils.dart';

import '../../../main.dart';

bool isLoading = false;
Future forgotPasswordService(email) async {
  authController.loading.value = true;
  var response = await http
      .post(Uri.parse(APIUtils.baseUrl + APIUtils.forgotPassword), headers: {
    "Authorization": APIUtils.bearerToken,
  }, body: {
    "email": email,
  });

  if (response.statusCode == 200) {
    authController.loading.value = false;
    return jsonDecode(response.body);
  } else {
    authController.loading.value = false;
    return jsonDecode(response.body);
  }
}
