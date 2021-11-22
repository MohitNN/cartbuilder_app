import 'package:http/http.dart' as http;
import 'package:mint_bird_app/main.dart';
import 'package:mint_bird_app/screens/product/API/scarcity/get_scarcity_product.dart';
import 'package:mint_bird_app/utils/api_utils.dart';
import 'package:mint_bird_app/widgets/app_snackbars.dart';

deleteAddedSale(String id, String type) async {
  var response = await http.post(
      Uri.parse(
        APIUtils.baseUrl + APIUtils.deleteAddedSale,
      ),
      headers: {
        "Authorization": "Bearer ${authController.userToken.value}",
      },
      body: {
        "id": id,
        "type": type
      });
  print(response.statusCode);
  print(response.body);
  if (response.statusCode == 200) {
    appSnackBar("Deleted Successfully", "$type is deleted successfully");
    getScarcityProductService();
  } else {
    errorSnackBar("Something went wrong", "Please try again!");
  }
}
