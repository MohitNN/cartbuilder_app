import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mint_bird_app/main.dart';
import 'package:mint_bird_app/screens/reporting/models/dashboard_model.dart';
import 'package:mint_bird_app/utils/api_utils.dart';
import 'package:mint_bird_app/widgets/app_snackbars.dart';

Future<DashBoardModel> getDashboardData() async {
  var response = await http
      .get(Uri.parse(APIUtils.baseUrl + APIUtils.getDashboard), headers: {
    "Authorization": "Bearer ${authController.userToken.value}",
  });
  Map<String, dynamic> decodedData = jsonDecode(response.body);
  if (response.statusCode == 200) {
    return DashBoardModel.fromJson(decodedData);
  } else {
    errorSnackBar("Something went wrong", "Please try again after sometime");
    return DashBoardModel();
  }
}
