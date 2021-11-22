import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:mint_bird_app/screens/mange_tags/API/get_transaction_service.dart';
import 'package:mint_bird_app/screens/mange_tags/controller/manege_tags_controller.dart';
import 'package:mint_bird_app/utils/api_utils.dart';
import 'package:mint_bird_app/widgets/app_snackbars.dart';
import 'package:mint_bird_app/widgets/get_toast.dart';

import '../../../main.dart';

createTagService() async {
  ManageTagController manageTagController = Get.put(ManageTagController());
  print(manageTagController.tagNameController.value.text);
  print(manageTagController.selectedUserGroupList.value);
  manageTagController.loading.value = true;
  var response = await http.post(
    Uri.parse(APIUtils.baseUrl + APIUtils.createTag),
    headers: {
      "Authorization": "Bearer ${authController.userToken.value}",
    },
    body: {
      "tag_name": manageTagController.tagNameController.value.text,
      "group_id": manageTagController.selectedUserGroupList.value,
    },
  );

  Map<String, dynamic> decodedData = jsonDecode(response.body);
  if (response.statusCode == 200) {
    if (decodedData["code"] == 200) {
      manageTagController.loading.value = false;
      getToast(msg: decodedData["response"]);
      getUserTagList();
      Get.back();
    }
  } else {
    manageTagController.loading.value = false;
    errorSnackBar("Something went wrong", "Please try again after some time");
  }
}
