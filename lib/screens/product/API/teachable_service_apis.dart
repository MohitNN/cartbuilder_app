import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:mint_bird_app/screens/auth/models/choose_account_data_model.dart';
import 'package:mint_bird_app/screens/product/controller/product_controller.dart';
import 'package:mint_bird_app/utils/api_utils.dart';
import 'package:mint_bird_app/widgets/get_toast.dart';

import '../../../main.dart';

getChooseAccountListTeachableService() async {
  ProductController productController = Get.put(ProductController());
  productController.chooseAccountLoadingTeachable.value = true;
  var response = await http.get(
      Uri.parse(APIUtils.baseUrl + APIUtils.getChooseAccountListTeachable),
      headers: {
        "Authorization": "Bearer ${authController.userToken.value}",
      });

  Map<String, dynamic> decodedData = jsonDecode(response.body);
  if (response.statusCode == 200) {
    if (UserDetailDataModel.fromJson(decodedData).response.length != 0) {
      productController.chooseAccountTeachable.clear();
      UserDetailDataModel.fromJson(decodedData).response.forEach((element) {
        productController.chooseAccountTeachable.add({
          "id": element.id,
          "name": element.account.membershipName,
        });
      });

      productController.selectedChooseAccountTeachable.value =
          productController.chooseAccountTeachable.first['id'].toString();
      productController.chooseAccountLoadingTeachable.value = false;
      getChooseCourseListTeachableService(
          productController.chooseAccountTeachable.first['id'].toString());
    } else {
      productController.chooseAccountTeachable.clear();
      productController.chooseAccountTeachable.add({
        "id": '',
        "name": 'No Account Available',
      });
      productController.chooseAccountLoadingTeachable.value = false;
      getChooseCourseListTeachableService('');
    }
  } else {
    productController.chooseAccountLoadingTeachable.value = false;
  }
}

getChooseCourseListTeachableService(String accountId) async {
  ProductController productController = Get.put(ProductController());
  productController.chooseCourseLoading.value = true;

  if (accountId.isNotEmpty) {
    var response = await http.get(
        Uri.parse(
          APIUtils.baseUrl +
              APIUtils.getChooseMemberShipListTeachable +
              '$accountId',
        ),
        headers: {
          "Authorization": "Bearer ${authController.userToken.value}",
        });

    Map<String, dynamic> decodedData = jsonDecode(response.body);
    if (response.statusCode == 200) {
      productController.chooseCourseTeachable.clear();
      decodedData["response"].forEach((element) {
        productController.chooseCourseTeachable.add({
          "id": element["id"].toString(),
          "name": element["name"],
        });
      });
      productController.selectedCourseTeachable.value =
          productController.chooseCourseTeachable.first["id"].toString();
      productController.chooseCourseLoading.value = false;
    } else {
      productController.chooseCourseLoading.value = false;
    }
  } else {
    productController.chooseCourseTeachable.clear();
    productController.chooseCourseTeachable.add({
      "id": '',
      "name": 'No Course Available',
    });
    productController.chooseCourseLoading.value = false;
  }
}

Future<bool> saveTeachableService() async {
  ProductController productController = Get.put(ProductController());
  productController.chooseAccountLoadingTeachable.value = true;
  var response = await http.post(
    Uri.parse(APIUtils.baseUrl + APIUtils.saveTeachable),
    headers: {
      "Authorization": "Bearer ${authController.userToken.value}",
    },
    body: {
      'connected_teachable_id':
          productController.selectedChooseAccountTeachable.value,
      'course_id': productController.selectedCourseTeachable.value,
      'product_id': productController.productId.value,
      'type': productController.productUpSellDownSell.value,
    },
  );

  Map<String, dynamic> decodedData = jsonDecode(response.body);
  if (response.statusCode == 200) {
    if (decodedData["status"] == true) {
      productController.chooseAccountLoadingTeachable.value = false;
      Get.back();
      getToast(msg: 'Teachable Saved Successfully');
      return true;
    } else {
      productController.chooseAccountLoadingTeachable.value = false;
      getToast(msg: "Something went wrong");
      return false;
    }
  } else {
    productController.chooseAccountLoadingTeachable.value = false;
    return false;
  }
}
