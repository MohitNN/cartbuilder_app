import 'dart:io';
import 'dart:ui';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:images_picker/images_picker.dart';
import 'package:mint_bird_app/screens/dashboard/widgets/create_product.dart';
import 'package:mint_bird_app/screens/product/API/update_product_templates_service.dart';
import 'package:mint_bird_app/screens/product/controller/check_out_design_controller.dart';
import 'package:mint_bird_app/utils/api_utils.dart';
import 'package:mint_bird_app/utils/m_colors.dart';
import 'package:mint_bird_app/utils/validator.dart';
import 'package:mint_bird_app/widgets/border_button.dart';
import 'package:mint_bird_app/widgets/custom_buttons.dart';
import 'package:mint_bird_app/widgets/customise_loading.dart';
import 'package:mint_bird_app/widgets/loading_image.dart';
import 'package:mint_bird_app/widgets/second_textfield.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../main.dart';
import '../../../widgets/loaders.dart';

class ProductCustomiseCheckoutDesign extends StatefulWidget {
  final String url;
  final String pId;

  const ProductCustomiseCheckoutDesign({Key key, this.url, this.pId})
      : super(key: key);

  @override
  _ProductCustomiseCheckoutDesignState createState() =>
      _ProductCustomiseCheckoutDesignState();
}

class _ProductCustomiseCheckoutDesignState
    extends State<ProductCustomiseCheckoutDesign> {
  CheckOutDesignController cK = Get.put(CheckOutDesignController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: Get.height,
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(top: 10.0, bottom: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Edit Page",
                    style: TextStyle(
                        color: mCustomizeTabText,
                        fontSize: 20.0,
                        fontWeight: FontWeight.w600),
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.subdirectory_arrow_left,
                        color: mCustomizeTabBorder,
                        size: 30.0,
                      ),
                      Container(
                          margin: EdgeInsets.only(left: 10.0),
                          child: Icon(
                            Icons.subdirectory_arrow_right,
                            color: mCustomizeTabBorder,
                            size: 30.0,
                          )),
                      InkWell(
                        onTap: () {
                          launch("https://chad.app.intecys.com/${widget.url}");
                        },
                        child: Container(
                            margin: EdgeInsets.only(left: 10.0),
                            padding: EdgeInsets.only(
                                left: 18.0, right: 18.0, top: 5.0, bottom: 5.0),
                            decoration: BoxDecoration(
                              border: Border.all(color: mCustomizeTabBorder),
                            ),
                            child: Icon(
                              Icons.remove_red_eye_rounded,
                              color: mCustomizeTabBorder,
                              size: 30.0,
                            )),
                      ),
                    ],
                  ),
                ],
              ),
            ),
//             Expanded(
//               child: Container(
//                   child: WebView(
//                 initialUrl: Uri.dataFromString(
//                         """<div id="SaasOnBoardContainer_2"></div>
// <script type="text/javascript" src="https://app.saasonboard.com/assets/custom/js/iframe/loginscreenlibrary.js"></script>
// <script type="text/javascript">
//   LoginScreenLibrary.init([
//       "SaasOnBoardContainer_2",
//       "https://app.saasonboard.com/",
//       "vStJEAiZZKI29bz",
//       "SaasOnBoardIFrame_2"
//   ]);
// </script>""",
//                         mimeType: 'text/html')
//                     .toString(),
//                 javascriptMode: JavascriptMode.unrestricted,
//               )),
//             ),
            Expanded(
                flex: 1,
                child: Obx(() {
                  return authController.loading.value
                      ? customiseLoading(hPad: 0)
                      : ListView(
                          children: [
                            editorContainer(
                                height: 37.67,
                                active: cK.noticeBarText.value,
                                child: items("EDIT NAVIGATION BAR"),
                                switchData: Switch(
                                    value: cK.noticeBarText.value,
                                    onChanged: (value) {
                                      cK.noticeBarText.value = value;
                                      updateProductTemplatesService(
                                          navigationBar: value,
                                          modalName: "navigation_bar");
                                    }),
                                onTap: () {
                                  editNavigationBar();
                                }),
                            SizedBox(
                              height: 11.33,
                            ),
                            editorContainer(
                                active: cK.cartHeader.value,
                                height: 125.67,
                                child: itemWithIcon(
                                    icon: Icons.shopping_cart_outlined,
                                    title: "EDIT CART HEADER"),
                                onTap: () {
                                  editCartHeader();
                                },
                                switchData: Switch(
                                    value: cK.cartHeader.value,
                                    onChanged: (value) {
                                      cK.cartHeader.value = value;
                                      updateProductTemplatesService(
                                          cartHeader: value,
                                          modalName: "navigation_bar");
                                    })),
                            SizedBox(
                              height: 11.33,
                            ),
                            editorContainer(
                                active: cK.sales.value,
                                height: 37.67,
                                child: items("EDIT SEALS"),
                                onTap: () {
                                  editSeals();
                                },
                                switchData: Switch(
                                    value: cK.sales.value,
                                    onChanged: (value) {
                                      cK.sales.value = value;
                                      updateProductTemplatesService(
                                          seals: value,
                                          modalName: "navigation_bar");
                                    })),
                            SizedBox(
                              height: 11.33,
                            ),
                            editorContainer(
                                active: cK.badges.value,
                                height: 37.67,
                                child: items("EDIT BADGES"),
                                onTap: () {
                                  editBadges();
                                },
                                switchData: Switch(
                                    value: cK.badges.value,
                                    onChanged: (value) {
                                      cK.badges.value = value;
                                      updateProductTemplatesService(
                                          badges: value,
                                          modalName: "navigation_bar");
                                    })),
                            SizedBox(
                              height: 11.33,
                            ),
                            editorContainer(
                                height: 125.67,
                                active: cK.image.value,
                                child: itemWithIcon(
                                    icon: Icons.image_outlined,
                                    title: "EDIT IMAGE"),
                                onTap: () {
                                  editImages();
                                },
                                switchData: Switch(
                                    value: cK.image.value,
                                    onChanged: (value) {
                                      cK.image.value = value;
                                      updateProductTemplatesService(
                                          editImage: value,
                                          modalName: "navigation_bar");
                                    })),
                            SizedBox(
                              height: 11.33,
                            ),
                            editorContainer(
                                active: cK.header.value,
                                height: 37.67,
                                child: items("EDIT FORM HEADER"),
                                onTap: () {
                                  editFormHeader();
                                },
                                switchData: Switch(
                                    value: cK.header.value,
                                    onChanged: (value) {
                                      cK.header.value = value;
                                      updateProductTemplatesService(
                                          formHeader: value,
                                          modalName: "navigation_bar");
                                    })),
                            SizedBox(
                              height: 11.33,
                            ),
                            editorContainer(
                                active: cK.bulletPoints.value,
                                height: 37.67,
                                child: items("EDIT BULLET POINTS"),
                                onTap: () {
                                  editBulletPoints();
                                },
                                switchData: Switch(
                                    value: cK.bulletPoints.value,
                                    onChanged: (value) {
                                      cK.bulletPoints.value = value;
                                      updateProductTemplatesService(
                                          bulletPoints: value,
                                          modalName: "navigation_bar");
                                    })),
                            SizedBox(
                              height: 11.33,
                            ),
                            editorContainer(
                                active: cK.testimonials.value,
                                height: 37.67,
                                child: items("EDIT TESTIMONIALS"),
                                onTap: () {
                                  editTestimonial();
                                },
                                switchData: Obx(() {
                                  return Switch(
                                      value: cK.testimonials.value,
                                      onChanged: (value) {
                                        cK.testimonials.value = value;
                                        updateProductTemplatesService(
                                            testimonial: value,
                                            modalName: "navigation_bar");
                                      });
                                })),
                          ],
                        );
                })),
          ],
        ),
      ),
    );
  }

  editNavigationBar() {
    editDialog(
        title: "Navigation bar Editor",
        onSave: () {
          sendImageInTemplate(
            templateEditType: "navigation_image",
          );
        },
        body: InkWell(
          onTap: () async {
            List<Media> res = await ImagesPicker.pick(
              count: 1,
              pickType: PickType.image,
            );
            if (res != null) {
              cK.navigationImagePath.value = res.first.path;
            }
          },
          child: Container(
              height: 200,
              alignment: Alignment.center,
              margin: EdgeInsets.only(left: 4.0, top: 20.0, bottom: 6.0),
              decoration: BoxDecoration(
                color: Color(0xffD8EDFC),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Stack(
                children: [
                  Center(
                    child: Text(
                      "Insert logo",
                      style: GoogleFonts.roboto(
                        color: mTextboxTitleColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 14.0,
                      ),
                    ),
                  ),
                  Obx(() {
                    return cK.navigationImagePath.value != null
                        ? cK.navigationImagePath.value
                                .contains(APIUtils.imageBaseUrl)
                            ? loadingImage(
                                cK.navigationImagePath.value,
                                height: 200,
                                width: double.infinity,
                                fit: BoxFit.contain,
                              )
                            : Image(
                                image: FileImage(
                                  File(cK.navigationImagePath.value),
                                ),
                                height: 200,
                                width: double.infinity,
                                fit: BoxFit.contain,
                              )
                        : SizedBox();
                  })
                ],
              )),
        ));
  }

  editCartHeader() {
    final GlobalKey<FormState> _editCartFormKey = GlobalKey<FormState>();

    editDialog(
        title: "Cart Editor",
        onSave: () {
          if (_editCartFormKey.currentState.validate()) {
            updateProductTemplatesService(
              templateEditType: "edit_title",
              productTitle: cK.titleController.value.text,
              productDescription: cK.descController.value.text,
            ).then((value) {
              if (value) {
                cK.titleController.value.text = cK.checkOutTemplateModel.value
                    .response.templateCode.productTitle;
                cK.descController.value.text = cK.checkOutTemplateModel.value
                    .response.templateCode.productDescription;
                Get.back();
              }
            });
          }
        },
        body: Form(
          key: _editCartFormKey,
          child: Obx(() {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                textFieldTitle("Product title"),
                SecondTextField(
                  controller: cK.titleController.value,
                  hintText: "Product title",
                  enabled: true,
                  obscureText: false,
                  validator: (val) {
                    return FieldValidator.validateValueIsEmpty(val);
                  },
                ),
                textFieldTitle("Product description"),
                SecondTextField(
                  controller: cK.descController.value,
                  hintText: "Product description",
                  enabled: true,
                  obscureText: false,
                  validator: (val) {
                    return FieldValidator.validateValueIsEmpty(val);
                  },
                ),
              ],
            );
          }),
        ));
  }

  editFormHeader() {
    final GlobalKey<FormState> _editFormHeaderFormKey = GlobalKey<FormState>();

    editDialog(
        title: "Form Editor",
        onSave: () {
          if (_editFormHeaderFormKey.currentState.validate()) {
            updateProductTemplatesService(
              templateEditType: "edit_form_header",
              productFormHeader1: cK.productFormHeader1Controller.value.text,
              productFromHeader2: cK.productFormHeader2Controller.value.text,
            ).then((value) {
              if (value) {
                cK.productFormHeader1Controller.value.text = cK
                    .checkOutTemplateModel
                    .value
                    .response
                    .templateCode
                    .productFormHeaderOne;
                cK.productFormHeader2Controller.value.text = cK
                    .checkOutTemplateModel
                    .value
                    .response
                    .templateCode
                    .productFormHeaderTwo;
                Get.back();
              }
            });
          }
        },
        body: Form(
          key: _editFormHeaderFormKey,
          child: Obx(() {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                textFieldTitle("Shipping"),
                SecondTextField(
                  controller: cK.productFormHeader1Controller.value,
                  hintText: "Shipping",
                  enabled: true,
                  obscureText: false,
                  validator: (val) {
                    return FieldValidator.validateValueIsEmpty(val);
                  },
                ),
                textFieldTitle("Billing"),
                SecondTextField(
                  controller: cK.productFormHeader2Controller.value,
                  hintText: "Billing",
                  enabled: true,
                  obscureText: false,
                  validator: (val) {
                    return FieldValidator.validateValueIsEmpty(val);
                  },
                ),
              ],
            );
          }),
        ));
  }

  editBulletPoints() {
    final GlobalKey<FormState> _editBulletFormKey = GlobalKey<FormState>();
    TextEditingController bulletController = TextEditingController();
    editDialog(
        title: "Bullet Editor",
        onSave: () {
          updateProductTemplatesService(
                  templateEditType: "edit_list", bulletPointList: cK.benefits)
              .then((value) {
            if (value) {
              Get.back();
            }
          });
        },
        body: Form(
          key: _editBulletFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              textFieldTitle("Benefit of your product"),
              SecondTextField(
                controller: bulletController,
                hintText: "Benefits",
                enabled: true,
                obscureText: false,
                validator: (val) {
                  return FieldValidator.validateValueIsEmpty(val);
                },
              ),
              Obx(() {
                return cK.benefits.length == 0
                    ? Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 15),
                          child: Text("No benefits added"),
                        ),
                      )
                    : ListView.builder(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        shrinkWrap: true,
                        itemCount: cK.benefits.length,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: EdgeInsets.only(bottom: 10),
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    offset: Offset(2, 2),
                                    blurRadius: 4,
                                  )
                                ],
                                border: Border.all(
                                    color: Color(0xffD8EDFC), width: 2),
                                borderRadius: BorderRadius.circular(6)),
                            child: Row(
                              children: [
                                Expanded(child: Text(cK.benefits[index])),
                                IconButton(
                                    onPressed: () {
                                      cK.benefits.removeAt(index);
                                    },
                                    icon: Icon(
                                      Icons.delete_outline_rounded,
                                      color: Colors.redAccent,
                                    ))
                              ],
                            ),
                          );
                        });
              }),
              Container(
                margin: EdgeInsets.only(top: 20.0),
                child: CustomButton(
                  width: Get.width,
                  height: 55.0,
                  text: "ADD".toUpperCase(),
                  onPressed: () {
                    if (_editBulletFormKey.currentState.validate()) {
                      cK.benefits.add(bulletController.text);
                    }
                  },
                  textColor: mWhiteColor,
                ),
              ),
            ],
          ),
        ));
  }

  editSeals() {
    final GlobalKey<FormState> _editSealFormKey = GlobalKey<FormState>();
    editDialog(
        title: "Seal Editor",
        onSave: () {
          sendImageInTemplate(templateEditType: "edit_seals");
        },
        body: Form(
          key: _editSealFormKey,
          child: Obx(() {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    InkWell(
                      onTap: () async {
                        List<Media> res = await ImagesPicker.pick(
                          count: 1,
                          pickType: PickType.image,
                        );
                        if (res != null) {
                          cK.seal1ImagePath.value = res.first.path;
                        }
                      },
                      child: Container(
                          height: 90,
                          width: 90,
                          alignment: Alignment.center,
                          color: Color(0xffD8EDFC),
                          margin: EdgeInsets.only(top: 20),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Icon(Icons.image_outlined),
                              Obx(() {
                                return cK.seal1ImagePath.value.length != null
                                    ? cK.seal1ImagePath.value
                                            .contains(APIUtils.imageBaseUrl)
                                        ? loadingImage(
                                            cK.seal1ImagePath.value,
                                            fit: BoxFit.contain,
                                            height: 90,
                                            width: 90,
                                          )
                                        : Image.file(
                                            File(
                                              cK.seal1ImagePath.value,
                                            ),
                                            fit: BoxFit.contain,
                                            height: 90,
                                            width: 90,
                                          )
                                    : SizedBox();
                              })
                            ],
                          )),
                    ),
                    Expanded(
                        child: Column(
                      children: [
                        textFieldTitle("Secure checkout"),
                        SecondTextField(
                          controller: cK.secureController.value,
                          hintText: "Secure checkout",
                          enabled: true,
                          obscureText: false,
                          validator: (val) {
                            return FieldValidator.validateValueIsEmpty(val);
                          },
                        ),
                      ],
                    ))
                  ],
                ),
                Row(
                  children: [
                    InkWell(
                      onTap: () async {
                        List<Media> res = await ImagesPicker.pick(
                          count: 1,
                          pickType: PickType.image,
                        );
                        if (res != null) {
                          cK.seal2ImagePath.value = res.first.path;
                        }
                      },
                      child: Container(
                        color: Color(0xffD8EDFC),
                        alignment: Alignment.center,
                        height: 90,
                        width: 90,
                        margin: EdgeInsets.only(top: 20),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Icon(Icons.image_outlined),
                            Obx(() {
                              return cK.seal2ImagePath.value.length != null
                                  ? cK.seal2ImagePath.value
                                          .contains(APIUtils.imageBaseUrl)
                                      ? loadingImage(
                                          cK.seal2ImagePath.value,
                                          fit: BoxFit.contain,
                                          height: 90,
                                          width: 90,
                                        )
                                      : Image.file(
                                          File(
                                            cK.seal2ImagePath.value,
                                          ),
                                          fit: BoxFit.contain,
                                          height: 90,
                                          width: 90,
                                        )
                                  : SizedBox();
                            })
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                        child: Column(
                      children: [
                        textFieldTitle("Money guarantee"),
                        SecondTextField(
                          controller: cK.moneyController.value,
                          hintText: "Money guarantee",
                          enabled: true,
                          obscureText: false,
                          validator: (val) {
                            return FieldValidator.validateValueIsEmpty(val);
                          },
                        ),
                      ],
                    ))
                  ],
                ),
              ],
            );
          }),
        ));
  }

  editTestimonial() {
    final GlobalKey<FormState> _editTestimonialFormKey = GlobalKey<FormState>();
    TextEditingController nameController = TextEditingController();
    TextEditingController messageController = TextEditingController();
    editDialog(
        title: "Testimonial Editor",
        onSave: () {
          updateProductTemplatesService(
                  templateEditType: "edit_testimonial",
                  testimonialList: cK.testimonialList)
              .then((value) {
            if (value) {
              Get.back();
            }
          });
        },
        body: Form(
          key: _editTestimonialFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  InkWell(
                    onTap: () async {
                      List<Media> res = await ImagesPicker.pick(
                        count: 1,
                        pickType: PickType.image,
                      );
                      if (res != null) {
                        cK.testimonialImagePath.value = res.first.path;
                      }
                    },
                    child: Container(
                        height: 115,
                        width: 100,
                        alignment: Alignment.center,
                        margin:
                            EdgeInsets.only(left: 4.0, top: 20.0, bottom: 6.0),
                        decoration: BoxDecoration(
                          color: Color(0xffD8EDFC),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Stack(
                          children: [
                            Center(child: Icon(Icons.image_outlined)),
                            Obx(() {
                              return cK.testimonialImagePath.value.length > 0
                                  ? Image(
                                      image: FileImage(
                                        File(cK.testimonialImagePath.value),
                                      ),
                                      height: 100,
                                      width: 100,
                                      fit: BoxFit.contain,
                                    )
                                  : SizedBox();
                            })
                          ],
                        )),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        SecondTextField(
                          controller: nameController,
                          hintText: "Mr john smith",
                          enabled: true,
                          obscureText: false,
                          validator: (val) {
                            return FieldValidator.validateValueIsEmpty(val);
                          },
                        ),
                        SecondTextField(
                          controller: messageController,
                          hintText: "This product is amazing.",
                          enabled: true,
                          obscureText: false,
                          validator: (val) {
                            return FieldValidator.validateValueIsEmpty(val);
                          },
                        ),
                      ],
                    ),
                  )
                ],
              ),
              Obx(() {
                return cK.testimonialList.length == 0
                    ? Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 15),
                          child: Text("No testimonial added"),
                        ),
                      )
                    : ListView.builder(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        shrinkWrap: true,
                        itemCount: cK.testimonialList.length,
                        itemBuilder: (context, index) {
                          return Container(
                            height: 90,
                            width: 90,
                            margin: EdgeInsets.only(bottom: 10),
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    offset: Offset(2, 2),
                                    blurRadius: 4,
                                  )
                                ],
                                border: Border.all(
                                    color: Color(0xffD8EDFC), width: 2),
                                borderRadius: BorderRadius.circular(6)),
                            child: Row(
                              children: [
                                Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Icon(Icons.image_outlined),
                                    Obx(() {
                                      return cK.testimonialList[index]
                                                  ["image"] !=
                                              null
                                          ? loadingImage(
                                              cK.testimonialList[index]
                                                  ["image"],
                                              fit: BoxFit.contain,
                                              height: 90,
                                              width: 90,
                                            )
                                          : SizedBox();
                                    })
                                  ],
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Expanded(
                                    child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      cK.testimonialList[index]["name"],
                                      style: TextStyle(fontSize: 16),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Text(
                                      cK.testimonialList[index]["msg"],
                                      overflow: TextOverflow.ellipsis,
                                    )
                                  ],
                                )),
                                IconButton(
                                    onPressed: () {
                                      cK.testimonialList.removeAt(index);
                                    },
                                    icon: Icon(
                                      Icons.delete_outline_rounded,
                                      color: Colors.redAccent,
                                    ))
                              ],
                            ),
                          );
                        });
              }),
              Container(
                margin: EdgeInsets.only(top: 20.0),
                child: CustomButton(
                  width: Get.width,
                  height: 55.0,
                  text: "ADD".toUpperCase(),
                  onPressed: () {
                    if (_editTestimonialFormKey.currentState.validate()) {
                      cK.testimonialList.add({
                        "name": nameController.text,
                        "msg": messageController.text,
                        "image": cK.testimonialImagePath.value
                      });
                    }
                  },
                  textColor: mWhiteColor,
                ),
              ),
            ],
          ),
        ));
  }

  editBadges() {
    editDialog(
        title: "Badges Editor",
        onSave: () {
          sendImageInTemplate(templateEditType: "edit_badges");
        },
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: () async {
                List<Media> res = await ImagesPicker.pick(
                  count: 1,
                  pickType: PickType.image,
                );
                if (res != null) {
                  cK.badge1ImagePath.value = res.first.path;
                }
              },
              child: Container(
                  height: 90,
                  color: Color(0xffD8EDFC),
                  margin: EdgeInsets.only(top: 20),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(32.0),
                        child: Icon(Icons.image_outlined),
                      ),
                      Obx(() {
                        return cK.badge1ImagePath.value.length != null
                            ? cK.badge1ImagePath.value
                                    .contains(APIUtils.imageBaseUrl)
                                ? loadingImage(
                                    cK.badge1ImagePath.value,
                                    fit: BoxFit.contain,
                                    height: 90,
                                    width: Get.width,
                                  )
                                : Image.file(
                                    File(
                                      cK.badge1ImagePath.value,
                                    ),
                                    fit: BoxFit.contain,
                                    height: 90,
                                    width: Get.width,
                                  )
                            : SizedBox();
                      })
                    ],
                  )),
            ),
            InkWell(
              onTap: () async {
                List<Media> res = await ImagesPicker.pick(
                    count: 1,
                    pickType: PickType.image,
                    cropOpt: CropOption(cropType: CropType.rect));
                if (res != null) {
                  cK.badge2ImagePath.value = res.first.path;
                }
              },
              child: Container(
                  height: 90,
                  color: Color(0xffD8EDFC),
                  margin: EdgeInsets.only(top: 20),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Icon(Icons.image_outlined),
                      Obx(() {
                        return cK.badge2ImagePath.value.length != null
                            ? cK.badge2ImagePath.value
                                    .contains(APIUtils.imageBaseUrl)
                                ? loadingImage(
                                    cK.badge2ImagePath.value,
                                    fit: BoxFit.contain,
                                    height: 90,
                                    width: Get.width,
                                  )
                                : Image.file(
                                    File(
                                      cK.badge2ImagePath.value,
                                    ),
                                    fit: BoxFit.contain,
                                    height: 90,
                                    width: Get.width,
                                  )
                            : SizedBox();
                      })
                    ],
                  )),
            ),
            InkWell(
              onTap: () async {
                List<Media> res = await ImagesPicker.pick(
                  count: 1,
                  pickType: PickType.image,
                );
                if (res != null) {
                  cK.badge3ImagePath.value = res.first.path;
                }
              },
              child: Container(
                  height: 90,
                  color: Color(0xffD8EDFC),
                  margin: EdgeInsets.only(top: 20),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(32.0),
                        child: Icon(Icons.image_outlined),
                      ),
                      Obx(() {
                        return cK.badge3ImagePath.value.length != null
                            ? cK.badge3ImagePath.value
                                    .contains(APIUtils.imageBaseUrl)
                                ? loadingImage(
                                    cK.badge3ImagePath.value,
                                    fit: BoxFit.contain,
                                    height: 90,
                                    width: Get.width,
                                  )
                                : Image.file(
                                    File(
                                      cK.badge3ImagePath.value,
                                    ),
                                    fit: BoxFit.contain,
                                    height: 90,
                                    width: Get.width,
                                  )
                            : SizedBox();
                      })
                    ],
                  )),
            ),
          ],
        ));
  }

  editImages() {
    editDialog(
        title: "Image Editor",
        onSave: () {
          sendImageInTemplate(templateEditType: "edit_image");
        },
        body: InkWell(
          onTap: () async {
            List<Media> res = await ImagesPicker.pick(
              count: 1,
              pickType: PickType.image,
            );
            if (res != null) {
              cK.imagePath.value = res.first.path;
            }
          },
          child: Container(
              height: 200,
              alignment: Alignment.center,
              margin: EdgeInsets.only(left: 4.0, top: 20.0, bottom: 6.0),
              decoration: BoxDecoration(
                color: Color(0xffD8EDFC),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Stack(
                children: [
                  Center(
                    child: Text(
                      "Insert Image",
                      style: GoogleFonts.roboto(
                        color: mTextboxTitleColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 14.0,
                      ),
                    ),
                  ),
                  Obx(() {
                    return cK.imagePath.value != null
                        ? cK.imagePath.value.contains(APIUtils.imageBaseUrl)
                            ? loadingImage(cK.imagePath.value,
                                height: 200,
                                width: double.infinity,
                                fit: BoxFit.contain)
                            : Image(
                                image: FileImage(
                                  File(cK.imagePath.value),
                                ),
                                height: 200,
                                width: double.infinity,
                                fit: BoxFit.contain,
                              )
                        : SizedBox();
                  })
                ],
              )),
        ));
  }

  Widget items(title) {
    return Text(
      title,
      style: getDefaultTextStyle(12, Color(0xff00A3F5),
          fontweight: FontWeight.bold),
    );
  }

  Widget itemWithIcon({IconData icon, String title}) {
    return Container(
      child: Column(
        children: [
          Container(
            child: Icon(
              icon,
              color: Color(0xff00A3F5),
              size: 50.0,
            ),
          ),
          SizedBox(
            height: 17.0,
          ),
          Text(
            title,
            style: getDefaultTextStyle(12, Color(0xff00A3F5),
                fontweight: FontWeight.w800),
          ),
        ],
      ),
    );
  }

  Widget editorContainer(
      {double height,
      Widget child,
      Widget switchData,
      VoidCallback onTap,
      bool active}) {
    return Container(
      color: active ? Color(0xffD8EDFC) : Colors.grey[100],
      margin: EdgeInsets.only(bottom: 5),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          splashColor: Colors.blueAccent.withOpacity(0.3),
          onTap: active ? onTap : () {},
          child: DottedBorder(
            color: Color(0xff86cdff), //color of dotted/dash line
            strokeWidth: 1, //thickness of dash/dots
            dashPattern: [5, 5],
            child: Container(
                padding: EdgeInsets.symmetric(vertical: 16),
                width: Get.width,
                child: Row(
                  children: [
                    Spacer(
                      flex: 2,
                    ),
                    child,
                    Spacer(),
                    switchData,
                  ],
                )),
          ),
        ),
      ),
    );
  }
}

Widget textFieldTitle(title) {
  return Container(
    alignment: Alignment.centerLeft,
    margin: EdgeInsets.only(left: 4.0, top: 20.0, bottom: 6.0),
    child: Text(
      title,
      style: GoogleFonts.roboto(
        color: mTextboxTitleColor,
        fontWeight: FontWeight.w500,
        fontSize: 14.0,
      ),
    ),
  );
}

editDialog({Widget body, String title, VoidCallback onSave}) {
  Get.dialog(Dialog(
    insetPadding: EdgeInsets.symmetric(horizontal: 16),
    child: Stack(
      children: [
        Positioned(
            left: 0,
            right: 0,
            height: 6.0,
            child: Container(
              decoration: BoxDecoration(
                  color: myellowColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10.0),
                    topRight: Radius.circular(10.0),
                  )),
              height: 6.0,
            )),
        Container(
          padding: EdgeInsets.only(left: 16.0, right: 16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                margin: EdgeInsets.only(left: 4.0, top: 16.0),
                child: Text(
                  title,
                  style: GoogleFonts.poppins(
                    color: mBlackColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 16.0,
                  ),
                ),
              ),
              body,
              Container(
                margin: EdgeInsets.only(top: 20.0),
                child: CustomButton(
                  width: Get.width,
                  height: 55.0,
                  text: "SAVE".toUpperCase(),
                  onPressed: onSave,
                  textColor: mWhiteColor,
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10.0, bottom: 20.0),
                child: BorderButton(
                  width: Get.width,
                  height: 55.0,
                  text: "Cancel".toUpperCase(),
                  onPressed: () {
                    Get.back();
                  },
                  textColor: mDisableTextColor,
                ),
              ),
            ],
          ),
        ),
        Obx(() {
          return authController.loading.value
              ? BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                  child: Container(
                    color: Colors.white.withOpacity(0.5),
                    child: appLoader,
                  ),
                )
              : SizedBox();
        })
      ],
    ),
  ));
}
