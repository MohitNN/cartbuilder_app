import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:mint_bird_app/screens/auth/models/choose_account_data_model.dart';
import 'package:mint_bird_app/screens/product/controller/product_controller.dart';
import 'package:mint_bird_app/utils/api_utils.dart';
import 'package:mint_bird_app/widgets/get_toast.dart';

import '../../../main.dart';

getChooseAccountListLifterLMSService() async {
  ProductController productController = Get.put(ProductController());
  productController.chooseAccountLoadingLifterLMS.value = true;
  var response = await http.get(
      Uri.parse(APIUtils.baseUrl + APIUtils.getChooseAccountListLifterLMS),
      headers: {
        "Authorization": "Bearer ${authController.userToken.value}",
      });

  Map<String, dynamic> decodedData = jsonDecode(response.body);
  if (response.statusCode == 200) {
    if (UserDetailDataModel.fromJson(decodedData).response.length != 0) {
      productController.chooseAccountLifterLMS.clear();
      UserDetailDataModel.fromJson(decodedData).response.forEach((element) {
        productController.chooseAccountLifterLMS.add({
          "id": element.id,
          "name": element.account.membershipName,
        });
      });

      productController.selectedChooseAccountLifterLMS.value =
          productController.chooseAccountLifterLMS.first['id'].toString();
      productController.chooseAccountLoadingLifterLMS.value = false;
      getChooseMemberShipListLifterLMSService(
          productController.chooseAccountLifterLMS.first['id'].toString());
      getChooseCourseListLifterLMSService(
          productController.chooseAccountLifterLMS.first['id'].toString());
    } else {
      productController.chooseAccountLifterLMS.clear();
      productController.chooseAccountLifterLMS.add({
        "id": '',
        "name": 'No Account Available',
      });
      productController.chooseAccountLoadingLifterLMS.value = false;
      getChooseCourseListLifterLMSService('');
      getChooseMemberShipListLifterLMSService('');
    }
  } else {
    productController.chooseAccountLoadingLifterLMS.value = false;
  }
}

getChooseCourseListLifterLMSService(String id) async {
  ProductController productController = Get.put(ProductController());
  productController.chooseCourseLoadingLifterLMS.value = true;

  if (id.isNotEmpty) {
    var response = await http.get(
        Uri.parse(
            APIUtils.baseUrl + APIUtils.getChooseCourseListLifterLMS + '$id'),
        headers: {
          "Authorization": "Bearer ${authController.userToken.value}",
        });

    Map<String, dynamic> decodedData = jsonDecode(response.body);
    if (response.statusCode == 200) {
      productController.chooseCourseLifterLMS.clear();
      decodedData["response"].forEach((element) {
        productController.chooseCourseLifterLMS.add({
          "id": element["id"].toString(),
          "name": element["name"].toString(),
        });
      });
      productController.selectedCourseLifterLMS.value =
          productController.chooseCourseLifterLMS.first["id"];
      productController.chooseCourseLoadingLifterLMS.value = false;
    } else {
      productController.chooseCourseLoadingLifterLMS.value = false;
    }
  } else {
    productController.chooseCourseLifterLMS.clear();
    productController.chooseCourseLifterLMS.add({
      "id": '',
      "name": 'No Course Available',
    });
    productController.chooseCourseLoadingLifterLMS.value = false;
  }
}

getChooseMemberShipListLifterLMSService(String id) async {
  ProductController productController = Get.put(ProductController());
  productController.chooseMemberShipLoadingLifterLMS.value = true;
  var response = await http.get(
      Uri.parse(
          APIUtils.baseUrl + APIUtils.getChooseMemberShipListLifterLMS + '$id'),
      headers: {
        "Authorization": "Bearer ${authController.userToken.value}",
      });

  Map<String, dynamic> decodedData = jsonDecode(response.body);
  if (response.statusCode == 200) {
    if (decodedData["response"].length != 0) {
      productController.chooseMembershipLifterLMS.clear();
      decodedData["response"].forEach((element) {
        productController.chooseMembershipLifterLMS.add({
          "id": element["id"].toString(),
          "name": element["name"].toString(),
        });
      });
      productController.selectedMemberShipLifterLMS.value =
          productController.chooseMembershipLifterLMS.first["id"];
      productController.chooseMemberShipLoadingLifterLMS.value = false;
    } else {
      productController.chooseMembershipLifterLMS.clear();
      productController.chooseMembershipLifterLMS.add({
        "id": '',
        "name": 'No MemberShip Available',
      });
      productController.chooseMemberShipLoadingLifterLMS.value = false;
    }
  } else {
    productController.chooseMemberShipLoadingLifterLMS.value = false;
  }
}

Future<bool> saveLifterLMSService() async {
  ProductController productController = Get.put(ProductController());
  productController.chooseAccountLoadingLifterLMS.value = true;
  var response = await http.post(
    Uri.parse(APIUtils.baseUrl + APIUtils.saveLifterLMS),
    headers: {
      "Authorization": "Bearer ${authController.userToken.value}",
    },
    body: {
      'connected_lifters_id':
          productController.selectedChooseAccountLifterLMS.value,
      'course_id': productController.selectedCourseMemberShip.value == 'course'
          ? productController.selectedCourseLifterLMS.value
          : '',
      'course_radio': productController.selectedCourseMemberShip.value,
      'membership_id':
          productController.selectedCourseMemberShip.value == 'membership'
              ? productController.selectedMemberShipLifterLMS.value
              : '',
      'product_id': productController.productId.value,
      'type': productController.productUpSellDownSell.value,
    },
  );

  Map<String, dynamic> decodedData = jsonDecode(response.body);
  if (response.statusCode == 200) {
    if (decodedData["status"] == true) {
      productController.chooseAccountLoadingLifterLMS.value = false;
      Get.back();
      getToast(msg: 'LifterLMS Saved Successfully');
      return true;
    } else {
      getToast(msg: "Something went wrong");
      return false;
    }
  } else {
    productController.chooseAccountLoadingLifterLMS.value = false;
    return false;
  }
}
