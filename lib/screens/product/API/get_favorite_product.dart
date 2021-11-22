import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mint_bird_app/main.dart';
import 'package:mint_bird_app/screens/product/models/favorite_product_model.dart';
import 'package:mint_bird_app/utils/api_utils.dart';

Future<List<FavoriteProduct>> getFavoriteProductService() async {
  var response = await http
      .get(Uri.parse(APIUtils.baseUrl + APIUtils.getFavoriteProduct), headers: {
    "Authorization": "Bearer ${authController.userToken.value}",
  });
  Map<String, dynamic> decodedData = jsonDecode(response.body);

  if (decodedData["code"] == 200) {
    return FavoriteProductModel.fromJson(jsonDecode(response.body)).response;
  } else {
    return [];
  }
}
