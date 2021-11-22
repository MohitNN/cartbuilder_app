import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mint_bird_app/main.dart';
import 'package:mint_bird_app/screens/product/models/recent_product_model.dart';
import 'package:mint_bird_app/utils/api_utils.dart';

Future<List<RecentProducts>> getRecentProductService() async {
  var response = await http
      .get(Uri.parse(APIUtils.baseUrl + APIUtils.getRecentProduct), headers: {
    "Authorization": "Bearer ${authController.userToken.value}",
  });
  Map<String, dynamic> decodedData = jsonDecode(response.body);
  if (decodedData["code"] == 200) {
    return RecentProductModel.fromJson(decodedData).response;
  } else {
    return [];
  }
}
