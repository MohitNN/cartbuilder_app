import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mint_bird_app/main.dart';
import 'package:mint_bird_app/screens/auth/models/user_connected_account_model.dart';
import 'package:mint_bird_app/utils/api_utils.dart';

getUserConnectedAccountService() async {
  var response = await http.get(
      Uri.parse(APIUtils.baseUrl + APIUtils.getUserConnectedAccount),
      headers: {
        "Authorization": "Bearer ${authController.userToken.value}",
      });
  Map<String, dynamic> decodedData = jsonDecode(response.body);

  if (decodedData["code"] == 200)
    creditCardProcessorList =
        UserConnectedAccountModel.fromJson(decodedData).creditCardProcessor;

  additionalPaymentOptionsList =
      UserConnectedAccountModel.fromJson(decodedData).additionalPaymentOptions;
}

List<CreditCardProcessor> creditCardProcessorList = [];
List<AdditionalPaymentOption> additionalPaymentOptionsList = [];

class SelectedPaymentOption {
  final String id;
  final String label;
  bool isSelected;

  SelectedPaymentOption({
    this.id = '',
    this.label = '',
    this.isSelected = false,
  });
}
