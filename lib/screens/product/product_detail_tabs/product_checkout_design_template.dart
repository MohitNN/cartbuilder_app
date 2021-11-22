import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mint_bird_app/main.dart';
import 'package:mint_bird_app/screens/product/API/update_product_checkout_design_service.dart';
import 'package:mint_bird_app/screens/product/API/update_two_step_form.dart';
import 'package:mint_bird_app/utils/m_colors.dart';
import 'package:mint_bird_app/utils/templates.dart';
import 'package:mint_bird_app/widgets/customise_loading.dart';
import 'package:mint_bird_app/widgets/loaders.dart';
import 'package:mint_bird_app/widgets/loading_image.dart';

import '../controller/product_controller.dart';

class ProductCheckoutDesignTemplate extends StatefulWidget {
  final String id;
  final String url;

  const ProductCheckoutDesignTemplate({Key key, this.id, this.url})
      : super(key: key);

  @override
  _ProductCheckoutDesignTemplateState createState() =>
      _ProductCheckoutDesignTemplateState();
}

class _ProductCheckoutDesignTemplateState
    extends State<ProductCheckoutDesignTemplate> {
  PageController pageController = PageController();
  ProductController productController = Get.put(ProductController());

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 24, left: 24, right: 24),
              child: Row(
                children: [
                  customTab(title: "Select Template", index: 0),
                  SizedBox(
                    width: 16,
                  ),
                  customTab(title: "Customise", index: 1),
                ],
              ),
            ),
            Obx(() {
              return productController.successTabIndex.value == 1
                  ? Expanded(
                      child: Stack(
                      children: [
                        InAppWebView(
                          onProgressChanged: (controller, value) {
                            productController.productLoads.value =
                                (value / 100).toDouble();
                          },
                          initialUrlRequest: URLRequest(
                              url: Uri.parse(
                                  "https://app.mintbird.com/customize-iframe-product/product/${productController.productId.value}")),
                        ),
                        productController.productLoads.value == 1.0
                            ? SizedBox()
                            : BackdropFilter(
                                filter: ImageFilter.blur(sigmaY: 5, sigmaX: 5),
                                child: Container(
                                  alignment: Alignment.center,
                                  color: Colors.white.withOpacity(0.5),
                                  child: appLoader,
                                ),
                              )
                        // : customiseLoading(),
                      ],
                    ))
                  : authController.loading.value
                      ? Expanded(
                          child: templatesLoading(
                              productController.twoStepForm.value == 0
                                  ? oneStepCheckOutTemplates.length
                                  : twoStepCheckOutTemplates.length))
                      : Expanded(
                          child: Column(
                            children: [
                              productController.isLoading.value
                                  ? Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 24, vertical: 10),
                                      child: shimmerLoadingCard2(
                                        height: 50,
                                        radius: 4,
                                      ),
                                    )
                                  : Row(
                                      children: [
                                        Expanded(
                                          child: RadioListTile(
                                            value: 0,
                                            groupValue: productController
                                                .twoStepForm.value,
                                            onChanged: (value) {
                                              updateTwoStepForm(value);
                                            },
                                            title: Text("One Step"),
                                          ),
                                        ),
                                        Expanded(
                                          child: RadioListTile(
                                            value: 1,
                                            groupValue: productController
                                                .twoStepForm.value,
                                            onChanged: (value) {
                                              updateTwoStepForm(value);
                                            },
                                            title: Text("Two Step"),
                                          ),
                                        ),
                                      ],
                                    ),
                              Expanded(
                                child: Obx(
                                  () => GridView.builder(
                                    physics: BouncingScrollPhysics(),
                                    itemCount:
                                        productController.twoStepForm.value == 0
                                            ? oneStepCheckOutTemplates.length
                                            : twoStepCheckOutTemplates.length,
                                    padding: EdgeInsets.only(
                                        left: 24, right: 24, bottom: 24),
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 2,
                                            crossAxisSpacing: 24,
                                            mainAxisSpacing: 24,
                                            childAspectRatio: 0.6),
                                    itemBuilder: (context, index) {
                                      return InkWell(
                                        splashColor: mPurple,
                                        onTap: () {
                                          updateProductCheckoutDesignService(
                                                  pId: widget.id,
                                                  tId: "${index + 1}")
                                              .then((value) {
                                            if (value) {
                                              productController
                                                  .selectedCheckoutTemplate
                                                  .value = index;
                                            }
                                          });
                                        },
                                        child: Obx(() {
                                          return Stack(
                                            fit: StackFit.loose,
                                            alignment: Alignment.bottomRight,
                                            children: [
                                              Container(
                                                height: 400,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(6),
                                                  border: productController
                                                              .selectedCheckoutTemplate
                                                              .value ==
                                                          index
                                                      ? Border.all(
                                                          color: mBtnColor,
                                                          width: 2,
                                                        )
                                                      : null,
                                                ),
                                                child: loadingImage(
                                                  productController.twoStepForm
                                                              .value ==
                                                          0
                                                      ? oneStepCheckOutTemplates[
                                                          index]
                                                      : twoStepCheckOutTemplates[
                                                          index],
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                              // AnimatedContainer(
                                              //   duration:
                                              //       Duration(milliseconds: 200),
                                              //   decoration: BoxDecoration(
                                              //       image: DecorationImage(
                                              //         image: NetworkImage(
                                              //             checkOutTemplates[index]),
                                              //         fit: BoxFit.cover,
                                              //       ),
                                              //       borderRadius:
                                              //           BorderRadius.circular(6),
                                              //       border: productController
                                              //                   .selectedCheckoutTemplate
                                              //                   .value ==
                                              //               index
                                              //           ? Border.all(
                                              //               color: mBtnColor,
                                              //               width: 2)
                                              //           : null),
                                              // ),
                                              productController
                                                          .selectedCheckoutTemplate
                                                          .value ==
                                                      index
                                                  ? Container(
                                                      padding:
                                                          EdgeInsets.all(5),
                                                      decoration: BoxDecoration(
                                                        color: mBtnColor,
                                                        borderRadius:
                                                            BorderRadius.only(
                                                          bottomRight:
                                                              Radius.circular(
                                                                  6),
                                                        ),
                                                      ),
                                                      child: Icon(
                                                        Icons.check,
                                                        color: Colors.white,
                                                      ),
                                                    )
                                                  : SizedBox()
                                            ],
                                          );
                                        }),
                                      );
                                    },
                                  ),
                                ),
                              )
                            ],
                          ),
                        );
            }),
          ],
        ),
      ],
    );
  }

  Widget customTab({String title, int index}) {
    return Expanded(
      child: Obx(
        () {
          return InkWell(
            onTap: () {
              if (index == 1) {
                productController.productLoads.value = 0.0;
                // getCheckoutTemplateDetailService(id: widget.id);
              }
              productController.successTabIndex.value = index;
            },
            child: AnimatedContainer(
              duration: Duration(milliseconds: 300),
              padding: EdgeInsets.symmetric(vertical: 10),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: productController.successTabIndex.value == index
                    ? mlightPurple
                    : Colors.white,
                border: Border.all(
                  color: productController.successTabIndex.value == index
                      ? mPurple
                      : mTextboxTitleColor,
                  width: 2,
                ),
              ),
              child: Text(
                title,
                style: GoogleFonts.inter(
                  color: productController.successTabIndex.value == index
                      ? mDarkPurple
                      : mTextboxTitleColor,
                  fontSize: 13,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
