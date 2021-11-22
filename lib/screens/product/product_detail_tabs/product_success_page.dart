import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
import 'package:mint_bird_app/screens/product/API/update_success_template.dart';
import 'package:mint_bird_app/screens/product/controller/product_controller.dart';
import 'package:mint_bird_app/utils/m_colors.dart';
import 'package:mint_bird_app/utils/templates.dart';
import 'package:mint_bird_app/widgets/customise_loading.dart';
import 'package:mint_bird_app/widgets/loading_image.dart';

class ProductSuccessPage extends StatefulWidget {
  final int selectedTemplate;

  const ProductSuccessPage({Key key, this.selectedTemplate}) : super(key: key);

  @override
  _ProductSuccessPageState createState() => _ProductSuccessPageState();
}

class _ProductSuccessPageState extends State<ProductSuccessPage> {
  PageController pageController = PageController();
  ProductController productController = Get.put(ProductController());

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(24),
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
        Container(
          child: Obx(() {
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
                                "https://app.mintbird.com/customize-iframe-product/success-page/${productController.productId.value}")),
                      ),
                      productController.productLoads.value == 1.0
                          ? SizedBox()
                          : Center(
                              child: Container(
                                height: 100,
                                width: 100,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.black.withOpacity(0.16),
                                          offset: Offset(2, 2),
                                          blurRadius: 6)
                                    ]),
                                child: LiquidCircularProgressIndicator(
                                  center: Text(
                                    "${((productController.productLoads.value) * 100)}",
                                    style: TextStyle(
                                        color: ((productController.productLoads
                                                            .value) *
                                                        100)
                                                    .ceil() >
                                                50
                                            ? Colors.white
                                            : mPrimaryColor1),
                                  ),
                                  value: productController.productLoads.value,
                                  backgroundColor: Colors.white,
                                  direction: Axis.vertical,
                                  valueColor:
                                      AlwaysStoppedAnimation(mPrimaryColor),
                                ),
                              ),
                            ),
                    ],
                  ))
                : productController.isLoading.value
                    ? Expanded(child: templatesLoading(successTemplates.length))
                    : Expanded(
                        child: GridView.builder(
                          physics: BouncingScrollPhysics(),
                          itemCount: successTemplates.length,
                          padding:
                              EdgeInsets.only(left: 24, right: 24, bottom: 24),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 24,
                            mainAxisSpacing: 24,
                            childAspectRatio: 0.6,
                          ),
                          itemBuilder: (context, index) {
                            return Container(
                              decoration: BoxDecoration(
                                color: mlightPurple,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                    splashColor: mPurple,
                                    onTap: () {
                                      productController.selectedSuccessTemplate
                                          .value = index;
                                      updateProductSuccessService();
                                    },
                                    child: Obx(() {
                                      return Stack(
                                        alignment: Alignment.bottomRight,
                                        children: [
                                          Container(
                                            height: 400,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(6),
                                              border: productController
                                                          .selectedSuccessTemplate
                                                          .value ==
                                                      index
                                                  ? Border.all(
                                                      color: mBtnColor,
                                                      width: 2,
                                                    )
                                                  : null,
                                            ),
                                            child: loadingImage(
                                              successTemplates[index],
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          // AnimatedContainer(
                                          //   duration: Duration(milliseconds: 200),
                                          //   decoration: BoxDecoration(
                                          //       image: DecorationImage(
                                          //         image: NetworkImage(
                                          //             successTemplates[index]),
                                          //         fit: BoxFit.cover,
                                          //       ),
                                          //       borderRadius:
                                          //           BorderRadius.circular(6),
                                          //       border: productController
                                          //                   .selectedSuccessTemplate
                                          //                   .value ==
                                          //               index
                                          //           ? Border.all(
                                          //               color: mBtnColor, width: 2)
                                          //           : null),
                                          // ),
                                          productController
                                                      .selectedSuccessTemplate
                                                      .value ==
                                                  index
                                              ? Container(
                                                  padding: EdgeInsets.all(5),
                                                  decoration: BoxDecoration(
                                                      color: mBtnColor,
                                                      borderRadius:
                                                          BorderRadius.only(
                                                              bottomRight:
                                                                  Radius
                                                                      .circular(
                                                                          6))),
                                                  child: Icon(
                                                    Icons.check,
                                                    color: Colors.white,
                                                  ),
                                                )
                                              : SizedBox()
                                        ],
                                      );
                                    })),
                              ),
                            );
                          },
                        ),
                      );
          }),
        ),

        // Expanded(
        //     child: PageView(
        //   physics: NeverScrollableScrollPhysics(),
        //   controller: pageController,
        //   onPageChanged: (value) {
        //     productController.successTabIndex.value = value;
        //   },
        //   children: [
        //     GridView.builder(
        //       itemCount: dummyData.length,
        //       padding: EdgeInsets.only(left: 24, right: 24, bottom: 24),
        //       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        //           crossAxisCount: 2,
        //           crossAxisSpacing: 24,
        //           mainAxisSpacing: 24,
        //           childAspectRatio: 0.6),
        //       itemBuilder: (context, index) {
        //         return Container(
        //           decoration: BoxDecoration(
        //             color: mlightPurple,
        //             borderRadius: BorderRadius.circular(6),
        //           ),
        //           child: Material(
        //             color: Colors.transparent,
        //             child: InkWell(
        //                 splashColor: mPurple,
        //                 onTap: () {
        //                   productController.selectedSuccessTemplate.value =
        //                       index;
        //                 },
        //                 child: Obx(() {
        //                   return Stack(
        //                     alignment: Alignment.bottomRight,
        //                     children: [
        //                       AnimatedContainer(
        //                         duration: Duration(milliseconds: 200),
        //                         decoration: BoxDecoration(
        //                             image: DecorationImage(
        //                               image: NetworkImage(dummyData[index]),
        //                               fit: BoxFit.cover,
        //                             ),
        //                             borderRadius: BorderRadius.circular(6),
        //                             border: productController
        //                                         .selectedSuccessTemplate
        //                                         .value ==
        //                                     index
        //                                 ? Border.all(color: mBtnColor, width: 2)
        //                                 : null),
        //                       ),
        //                       productController.selectedSuccessTemplate.value ==
        //                               index
        //                           ? Container(
        //                               padding: EdgeInsets.all(5),
        //                               decoration: BoxDecoration(
        //                                   color: mBtnColor,
        //                                   borderRadius: BorderRadius.only(
        //                                       bottomRight: Radius.circular(6))),
        //                               child: Icon(
        //                                 Icons.check,
        //                                 color: Colors.white,
        //                               ),
        //                             )
        //                           : SizedBox()
        //                     ],
        //                   );
        //                 })),
        //           ),
        //         );
        //       },
        //     ),
        //     Center(
        //       child: Text("Customise"),
        //     )
        //   ],
        // ))
      ],
    );
  }

  Widget customTab({String title, int index}) {
    return Expanded(
      child: Obx(
        () {
          return InkWell(
            onTap: () {
              productController.successTabIndex.value = index;
              // pageController.animateToPage(index,
              //     duration: Duration(milliseconds: 200), curve: Curves.ease);
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
