import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mint_bird_app/screens/product/product_detail_tabs/product_add_everlesson_screen.dart';
import 'package:mint_bird_app/screens/product/product_detail_tabs/product_teachable_tab.dart';
import 'package:mint_bird_app/utils/m_colors.dart';

import '../../product/product_detail_tabs/lifterLMS_screen.dart';

class ProductDeliveryOptions extends StatefulWidget {
  final List<SelectedProductDeliveryOptions> selectedProductDeliveryOption;

  const ProductDeliveryOptions({Key key, this.selectedProductDeliveryOption})
      : super(key: key);

  @override
  _ProductDeliveryOptionsState createState() => _ProductDeliveryOptionsState();
}

class _ProductDeliveryOptionsState extends State<ProductDeliveryOptions> {
  openDialog(String label) {
    switch (label) {
      case 'EverLesson':
        addEverLesson(widget.selectedProductDeliveryOption[0]);
        break;
      case 'Thinkific':
        break;
      case 'Teachable':
        addTeachable(widget.selectedProductDeliveryOption[2]);
        break;
      case 'MemberMouse':
        break;
      case 'MemberPress':
        break;
      case 'WishList':
        break;
      case 'LifterLMS':
        addLifterLMS(widget.selectedProductDeliveryOption[6]);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height * 0.2,
      child: GridView.builder(
        itemCount: widget.selectedProductDeliveryOption.length,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
          childAspectRatio: 2.5,
        ),
        itemBuilder: (context, index) => GestureDetector(
          onTap: () {
            widget.selectedProductDeliveryOption
                .forEach((element) => element.isSelected = false);
            setState(() {
              widget.selectedProductDeliveryOption[index].isSelected = true;
            });
            openDialog(widget.selectedProductDeliveryOption[index].title);
          },
          child: Container(
            margin: EdgeInsets.all(5.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(
                color: widget.selectedProductDeliveryOption[index].isSelected
                    ? Colors.blue
                    : Colors.transparent,
                width: 3,
              ),
            ),
            child: Stack(
              alignment: Alignment.bottomRight,
              children: [
                AnimatedContainer(
                  duration: Duration(milliseconds: 200),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                        widget.selectedProductDeliveryOption[index].label,
                      ),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(6),
                    border:
                        widget.selectedProductDeliveryOption[index].isSelected
                            ? Border.all(color: mBtnColor, width: 1)
                            : null,
                  ),
                ),
                if (widget.selectedProductDeliveryOption[index].isSelected)
                  Container(
                    decoration: BoxDecoration(
                      color: mBtnColor,
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(6),
                      ),
                    ),
                    child: Icon(
                      Icons.check,
                      color: Colors.white,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SelectedProductDeliveryOptions {
  final String label;
  final String title;
  bool isSelected;

  SelectedProductDeliveryOptions({
    this.label = '',
    this.title,
    this.isSelected = false,
  });
}
