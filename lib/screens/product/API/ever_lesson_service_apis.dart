import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:mint_bird_app/screens/auth/models/choose_account_data_model.dart';
import 'package:mint_bird_app/screens/product/controller/product_controller.dart';
import 'package:mint_bird_app/utils/api_utils.dart';
import 'package:mint_bird_app/widgets/get_toast.dart';

import '../../../main.dart';

getChooseAccountListService() async {
  ProductController productController = Get.put(ProductController());
  productController.chooseAccountLoading.value = true;
  var response = await http.get(
      Uri.parse(APIUtils.baseUrl + APIUtils.getChooseAccountList),
      headers: {
        "Authorization": "Bearer ${authController.userToken.value}",
      });

  Map<String, dynamic> decodedData = jsonDecode(response.body);
  if (response.statusCode == 200) {
    if (UserDetailDataModel.fromJson(decodedData).response.length != 0) {
      productController.chooseAccountEverLesson.clear();
      UserDetailDataModel.fromJson(decodedData).response.forEach((element) {
        productController.chooseAccountEverLesson.add({
          "id": element.id,
          "name": element.account.membershipName,
        });
      });

      productController.selectedChooseAccount.value =
          productController.chooseAccountEverLesson.first['id'].toString();
      productController.chooseAccountLoading.value = false;
      getChooseMemberShipListService(
          productController.chooseAccountEverLesson.first['id'].toString());
    } else {
      productController.chooseAccountEverLesson.clear();
      productController.chooseAccountEverLesson.add({
        "id": '',
        "name": 'No Account Available',
      });
      productController.chooseAccountLoading.value = false;
      getChooseMemberShipListService('');
    }
  } else {
    productController.chooseAccountLoading.value = false;
  }
}

getChooseMemberShipListService(String id) async {
  ProductController productController = Get.put(ProductController());
  productController.chooseMemberShipLoading.value = true;
  var response = await http.get(
      Uri.parse(APIUtils.baseUrl + APIUtils.getChooseMemberShipList + '$id'),
      headers: {
        "Authorization": "Bearer ${authController.userToken.value}",
      });

  Map<String, dynamic> decodedData = jsonDecode(response.body);
  if (response.statusCode == 200) {
    if (decodedData["response"].length != 0) {
      productController.chooseMembershipEverLesson.clear();
      decodedData["response"].forEach((element) {
        productController.chooseMembershipEverLesson.add({
          "id": element["membership_id"],
          "name": element["membership_name"],
        });
      });
      productController.selectedMemberShip.value =
          productController.chooseMembershipEverLesson.first["id"];
      productController.chooseMemberShipLoading.value = false;
    } else {
      productController.chooseMembershipEverLesson.clear();
      productController.chooseMembershipEverLesson.add({
        "id": '',
        "name": 'No MemberShip Available',
      });
      productController.chooseMemberShipLoading.value = false;
    }
  } else {
    productController.chooseMemberShipLoading.value = false;
  }
  getChooseLevelListService('', '');
}

getChooseLevelListService(String memberShipId, String accountId) async {
  ProductController productController = Get.put(ProductController());
  productController.chooseLevelLoading.value = true;

  if (memberShipId.isNotEmpty && accountId.isNotEmpty) {
    var response = await http.get(
        Uri.parse(APIUtils.baseUrl +
            APIUtils.getChooseLevelList +
            '$memberShipId/level/$accountId'),
        headers: {
          "Authorization": "Bearer ${authController.userToken.value}",
        });

    Map<String, dynamic> decodedData = jsonDecode(response.body);
    if (response.statusCode == 200) {
      productController.chooseLevelEverLesson.clear();
      decodedData["response"].forEach((element) {
        productController.chooseLevelEverLesson.add({
          "id": element["level_id"],
          "name": element["level_name"],
        });
      });
      productController.selectedLevel.value =
          productController.chooseLevelEverLesson.first["id"];
      productController.chooseLevelLoading.value = false;
    } else {
      productController.chooseLevelLoading.value = false;
    }
  } else {
    productController.chooseLevelEverLesson.clear();
    productController.chooseLevelEverLesson.add({
      "id": '',
      "name": 'No Level Available',
    });
    productController.chooseLevelLoading.value = false;
  }
  getChooseCourseListService('', '');
}

getChooseCourseListService(String memberShipId, String accountId) async {
  ProductController productController = Get.put(ProductController());
  productController.chooseCourseLoading.value = true;

  if (memberShipId.isNotEmpty && accountId.isNotEmpty) {
    var response = await http.get(
        Uri.parse(APIUtils.baseUrl +
            APIUtils.getChooseCourseList +
            '$memberShipId/$accountId'),
        headers: {
          "Authorization": "Bearer ${authController.userToken.value}",
        });

    Map<String, dynamic> decodedData = jsonDecode(response.body);
    if (response.statusCode == 200) {
      productController.chooseCourseEverLesson.clear();
      decodedData["response"].forEach((element) {
        productController.chooseCourseEverLesson.add({
          "id": element["product_id"],
          "name": element["product_name"],
        });
      });
      productController.selectedCourse.value =
          productController.chooseCourseEverLesson.first["id"];
      productController.chooseCourseLoading.value = false;
    } else {
      productController.chooseCourseLoading.value = false;
    }
  } else {
    productController.chooseCourseEverLesson.clear();
    productController.chooseCourseEverLesson.add({
      "id": '',
      "name": 'No Course Available',
    });
    productController.chooseCourseLoading.value = false;
  }
  getChooseActionOptionListService();
}

getChooseActionOptionListService({
  String memberShipId = '',
  String courseId = '',
  String accountId = '',
}) async {
  ProductController productController = Get.put(ProductController());
  productController.chooseActionOptionLoading.value = true;
  if (memberShipId.isNotEmpty && courseId.isNotEmpty && accountId.isNotEmpty) {
    var response = await http.get(
        Uri.parse(APIUtils.baseUrl +
            APIUtils.getChooseAccessOptionList +
            '$memberShipId/$courseId/$accountId'),
        headers: {
          "Authorization": "Bearer ${authController.userToken.value}",
        });

    Map<String, dynamic> decodedData = jsonDecode(response.body);
    if (response.statusCode == 200) {
      productController.chooseActionOptionEverLesson.clear();
      decodedData["response"].forEach((element) {
        productController.chooseActionOptionEverLesson.add({
          "id": element["package_id"],
          "name": element["package_name"],
        });
      });
      productController.selectedActionOption.value =
          productController.chooseActionOptionEverLesson.first["id"];
      productController.chooseActionOptionLoading.value = false;
    } else {
      productController.chooseActionOptionLoading.value = false;
    }
  } else {
    productController.chooseActionOptionEverLesson.clear();
    productController.chooseActionOptionEverLesson.add({
      "id": '',
      "name": 'No Action Options Available',
    });
    productController.chooseActionOptionLoading.value = false;
  }
}

Future<bool> saveEverLessonService() async {
  ProductController productController = Get.put(ProductController());
  productController.chooseAccountLoading.value = true;
  var response = await http.post(
    Uri.parse(APIUtils.baseUrl + APIUtils.saveEverLesson),
    headers: {
      "Authorization": "Bearer ${authController.userToken.value}",
    },
    body: {
      'membership_id': productController.selectedMemberShip.value,
      'course_id': productController.selectedCourse.value,
      'level_id': productController.selectedLevel.value,
      'access_option_id': productController.selectedActionOption.value,
      'course_level_radio': productController.selectedCourseLevel.value,
      'connected_everlession_id': productController.selectedChooseAccount.value,
      'type': productController.productUpSellDownSell.value,
      'product_id': productController.productId.value,
    },
  );

  Map<String, dynamic> decodedData = jsonDecode(response.body);
  if (response.statusCode == 200) {
    if (decodedData["status"] == true) {
      productController.chooseAccountLoading.value = false;
      Get.back();
      getToast(msg: 'EverLesson Saved Successfully');
      return true;
    } else {
      getToast(msg: "Something went wrong");
      return false;
    }
  } else {
    productController.chooseAccountLoading.value = false;
    return false;
  }
}
