import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mint_bird_app/screens/upsell/API/save_type_of_delivery.dart';
import 'package:mint_bird_app/screens/upsell/controller/upsell_controller.dart';
import 'package:mint_bird_app/utils/m_colors.dart';

import 'membership_platform_list_widget.dart';

class ProductDeliveryPage extends StatefulWidget {
  final String membershipPlatform;
  final String id;

  const ProductDeliveryPage(
      {this.membershipPlatform = '', @required this.id, Key key})
      : super(key: key);

  @override
  _ProductDeliveryPageState createState() => _ProductDeliveryPageState();
}

class _ProductDeliveryPageState extends State<ProductDeliveryPage> {
  UpsellController upsellController = Get.put(UpsellController());
  List<SelectedProductDeliveryOptions> membershipsList = [
    SelectedProductDeliveryOptions(
      label: 'https://app.intecys.com/assets/images/platform-2.png',
      title: 'EverLesson',
      isSelected: false,
    ),
    SelectedProductDeliveryOptions(
      label: 'https://app.intecys.com/assets/images/platform-3.png',
      title: 'Thinkific',
      isSelected: false,
    ),
    SelectedProductDeliveryOptions(
      label: 'https://app.intecys.com/assets/images/platform-4.png',
      title: 'Teachable',
      isSelected: false,
    ),
    SelectedProductDeliveryOptions(
      label: 'https://app.intecys.com/public/img/membermouse.png',
      title: 'MemberMouse',
      isSelected: false,
    ),
    SelectedProductDeliveryOptions(
      label: 'https://app.intecys.com/public/img/memberpress.png',
      title: 'MemberPress',
      isSelected: false,
    ),
    SelectedProductDeliveryOptions(
      label: 'https://app.intecys.com/public/img/wishlist.png',
      title: 'WishList',
      isSelected: false,
    ),
    SelectedProductDeliveryOptions(
      label: 'https://app.intecys.com/public/img/Llms.png',
      title: 'LifterLMS',
      isSelected: false,
    ),
  ];

  @override
  void initState() {
    print(widget.membershipPlatform);
    upsellController.selectedTypeOfDelivery.value =
        (widget.membershipPlatform == 'membership')
            ? 'Membership Platform'
            : 'Please Select type of delivery';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 20.0, right: 20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(left: 4.0, top: 15.0, bottom: 6.0),
            child: Text(
              "Select Group",
              style: GoogleFonts.roboto(
                color: mTextboxTitleColor,
                fontWeight: FontWeight.w500,
                fontSize: 15.0,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 4.0, top: 15.0, bottom: 6.0),
            padding: EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: mWhiteColor,
              border: Border.all(color: mborderColor),
            ),
            child: Obx(
              () => DropdownButton(
                underline: SizedBox(),
                value: upsellController.selectedTypeOfDelivery.value,
                hint: upsellController.selectedTypeOfDelivery == ''.obs
                    ? Text(' Please Select type of Delivery')
                    : Text(
                        upsellController.selectedTypeOfDelivery.value
                            .toString(),
                        style: TextStyle(color: Colors.blue),
                      ),
                isExpanded: true,
                iconSize: 30.0,
                style: TextStyle(color: Colors.blue),
                items: ['Please Select type of delivery', 'Membership Platform']
                    .map(
                  (String val) {
                    return DropdownMenuItem<String>(
                      value: val,
                      child: Text(val),
                    );
                  },
                ).toList(),
                onChanged: (String val) {
                  setState(() {
                    upsellController.selectedTypeOfDelivery = val.obs;
                  });
                  saveTypeOfDelivery(
                    id: widget.id,
                    type: (upsellController.selectedTypeOfDelivery.value ==
                            'Membership Platform')
                        ? 'membership'
                        : 'select',
                  );
                },
              ),
            ),
          ),
          if (upsellController.selectedTypeOfDelivery.value ==
              'Membership Platform')
            Expanded(
              child: ProductDeliveryOptions(
                selectedProductDeliveryOption: membershipsList,
              ),
            )
        ],
      ),
    );
  }
}
