import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:mint_bird_app/main.dart';
import 'package:mint_bird_app/screens/mange_tags/controller/manege_tags_controller.dart';
import 'package:mint_bird_app/screens/mange_tags/models/user_group_list_model.dart';
import 'package:mint_bird_app/utils/api_utils.dart';
import 'package:mint_bird_app/widgets/app_snackbars.dart';

getUserGroupList() async {
  ManageTagController manageTagController = Get.put(ManageTagController());

  var response = await http
      .get(Uri.parse(APIUtils.baseUrl + APIUtils.getUserGroupList), headers: {
    "Authorization": "Bearer ${authController.userToken.value}",
  });

  print(response.statusCode);
  print(response.body);
  Map<String, dynamic> decodedData = jsonDecode(response.body);
  if (response.statusCode == 200) {
    if (decodedData["status"] == 'Success') {
      manageTagController.userGroupList.clear();
      UserGroupListDataModel.fromJson(decodedData).data.forEach((element) {
        if (element.isactive == 1)
          manageTagController.userGroupList.add(element);
      });
      manageTagController.loading.value = false;
    } else {
      manageTagController.loading.value = false;
      errorSnackBar("Something went wrong", "Please try again after sometime");
    }
  }
}
