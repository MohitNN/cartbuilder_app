import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:mint_bird_app/screens/auth/API/get_user_detail.dart';
import 'package:mint_bird_app/screens/dashboard/controller/dashboard_controller.dart';
import 'package:mint_bird_app/utils/api_utils.dart';
import 'package:mint_bird_app/widgets/app_snackbars.dart';
import 'package:mint_bird_app/widgets/get_toast.dart';

import '../../../../../main.dart';

updateProfilePhoto({String imagePath}) async {
  DashboardController dashboardController = Get.put(DashboardController());
  dashboardController.accountLoading.value = true;
  Uri url = Uri.parse(APIUtils.baseUrl + APIUtils.updateProfilePicture);
  Map<String, String> headers = {
    "Authorization": "Bearer ${authController.userToken.value}",
  };
  var request = http.MultipartRequest("POST", url);
  request.headers.addAll(headers);
  request.files
      .add(await http.MultipartFile.fromPath("profile_pic", imagePath));

  var response = await request.send();
  print(response.statusCode);
  response.stream.transform(utf8.decoder).listen((value) {
    print(value);
  });
  if (response.statusCode == 200) {
    await getUserDetails();
    getToast(msg: "Profile updated successfully");
    dashboardController.accountLoading.value = false;
  } else {
    dashboardController.accountLoading.value = false;
    errorSnackBar("Something went wrong!", "Please try again later");
  }
}
