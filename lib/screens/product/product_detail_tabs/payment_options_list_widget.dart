import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mint_bird_app/screens/auth/API/get_user_connected_account.dart';
import 'package:mint_bird_app/screens/product/API/update_payment_status.dart';
import 'package:mint_bird_app/screens/product/controller/product_controller.dart';
import 'package:mint_bird_app/utils/app_strings.dart';

class SingleSelectionPaymentOptions extends StatefulWidget {
  final List<SelectedPaymentOption> selectedPaymentOption;
  final String assetNetwork;

  const SingleSelectionPaymentOptions({Key key, this.selectedPaymentOption, this.assetNetwork})
      : super(key: key);

  @override
  _SingleSelectionPaymentOptionsState createState() => _SingleSelectionPaymentOptionsState();
}

class _SingleSelectionPaymentOptionsState extends State<SingleSelectionPaymentOptions> {
  @override
  Widget build(BuildContext context) {
    ProductController productController = Get.put(ProductController());
    return Wrap(
      children: [
        for (int index = 0; index < widget.selectedPaymentOption.length; index++)
          Container(
            width: Get.width * 0.26,
            height: Get.height * 0.06,
            margin: EdgeInsets.all(5.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(3.0),
              border: Border.all(
                color: widget.selectedPaymentOption[index].isSelected
                    ? Colors.blue
                    : Colors.transparent,
                width: 3,
              ),
            ),
            child: GestureDetector(
              onTap: () {
                updatePaymentStatusService(
                  id: widget.selectedPaymentOption[index].id,
                  productId: productController.productId.value,
                  type: widget.selectedPaymentOption[index].label,
                );
                bool sameId = false;
                widget.selectedPaymentOption.forEach((element) {
                  if (widget.selectedPaymentOption[index].id == element.id &&
                      widget.selectedPaymentOption[index].isSelected) {
                    sameId = true;
                  }
                  element.isSelected = false;
                });
                setState(() {
                  if (!sameId) widget.selectedPaymentOption[index].isSelected = true;
                });
              },
              child: (widget.assetNetwork == 'network')
                  ? Image.network(
                      widget.selectedPaymentOption[index].label,
                      fit: BoxFit.fill,
                    )
                  : Image.asset(
                      AppString.iconImagesPath + widget.selectedPaymentOption[index].label + '.png',
                      fit: BoxFit.fill,
                    ),
            ),
          ),
      ],
    );
  }
}

class MultiSelectionPaymentOptions extends StatefulWidget {
  final List<SelectedPaymentOption> selectedPaymentOption;
  final String assetNetwork;

  const MultiSelectionPaymentOptions({Key key, this.selectedPaymentOption, this.assetNetwork})
      : super(key: key);

  @override
  _MultiSelectionPaymentOptionsState createState() => _MultiSelectionPaymentOptionsState();
}

class _MultiSelectionPaymentOptionsState extends State<MultiSelectionPaymentOptions> {
  @override
  Widget build(BuildContext context) {
    ProductController productController = Get.put(ProductController());
    return Wrap(
      children: [
        for (int index = 0; index < widget.selectedPaymentOption.length; index++)
          Container(
            width: Get.width * 0.26,
            height: Get.height * 0.06,
            margin: EdgeInsets.all(5.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(3.0),
              border: Border.all(
                color: widget.selectedPaymentOption[index].isSelected
                    ? Colors.blue
                    : Colors.transparent,
                width: 3,
              ),
            ),
            child: GestureDetector(
              onTap: () {
                updatePaymentStatusService(
                  id: widget.selectedPaymentOption[index].id,
                  productId: productController.productId.value,
                  type: widget.selectedPaymentOption[index].label,
                );
                widget.selectedPaymentOption.forEach((element) {
                  if (element.label == widget.selectedPaymentOption[index].label &&
                      element.id != widget.selectedPaymentOption[index].id) {
                    element.isSelected = false;
                  }
                });
                setState(() {
                  widget.selectedPaymentOption[index].isSelected =
                      !widget.selectedPaymentOption[index].isSelected;
                });
              },
              child: (widget.assetNetwork == 'network')
                  ? Image.network(
                      widget.selectedPaymentOption[index].label,
                      fit: BoxFit.fill,
                    )
                  : Image.asset(
                      AppString.iconImagesPath + widget.selectedPaymentOption[index].label + '.png',
                      fit: BoxFit.fill,
                    ),
            ),
          ),
      ],
    );
  }
}
