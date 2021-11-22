import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:mint_bird_app/main.dart';
import 'package:mint_bird_app/screens/mange_tags/controller/manege_tags_controller.dart';
import 'package:mint_bird_app/screens/mange_tags/models/user_tag_list_model.dart';
import 'package:mint_bird_app/utils/api_utils.dart';
import 'package:mint_bird_app/widgets/app_snackbars.dart';

getUserTagList() async {
  ManageTagController manageTagController = Get.put(ManageTagController());
  manageTagController.loading.value = true;
  var response = await http
      .get(Uri.parse(APIUtils.baseUrl + APIUtils.getUserTags), headers: {
    "Authorization": "Bearer ${authController.userToken.value}",
  });
  print(response.statusCode);
  print(response.body);
  Map<String, dynamic> decodedData = jsonDecode(response.body);
  if (response.statusCode == 200) {
    if (decodedData["status"] == 'Success') {
      manageTagController.userTags.clear();
      manageTagController.userTags = UserTagListDataModel
          .fromJson(decodedData)
          .data.obs;
      manageTagController.loading.value = false;
    } else {
      manageTagController.loading.value = false;
      errorSnackBar("Something went wrong", "Please try again after sometime");
    }
  }
}

