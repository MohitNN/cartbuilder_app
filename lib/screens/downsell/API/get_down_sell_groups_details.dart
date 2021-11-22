import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mint_bird_app/main.dart';
import 'package:mint_bird_app/screens/product/models/group_data_model.dart';
import 'package:mint_bird_app/utils/api_utils.dart';

getDownSellGroupsDetailsService() async {
  var response = await http
      .get(Uri.parse(APIUtils.baseUrl + APIUtils.getDownSellGroup), headers: {
    "Authorization": "Bearer ${authController.userToken.value}",
  });
  Map<String, dynamic> decodedData = jsonDecode(response.body);
  if (decodedData["code"] == 200)
    downSellGroups = GroupDataModel.fromJson(decodedData).response;
}

List<Groups> downSellGroups = [];
