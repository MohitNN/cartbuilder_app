import 'dart:io';
import 'dart:ui';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:images_picker/images_picker.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
import 'package:mint_bird_app/main.dart';
import 'package:mint_bird_app/screens/dashboard/widgets/create_product.dart';
import 'package:mint_bird_app/screens/product/product_detail_tabs/product_customise_checkout_design.dart';
import 'package:mint_bird_app/screens/upsell/API/customise/get_upsell_template_customise_data.dart';
import 'package:mint_bird_app/screens/upsell/API/customise/save_upsell_customise_template.dart';
import 'package:mint_bird_app/screens/upsell/API/set_upsell_template.dart';
import 'package:mint_bird_app/screens/upsell/controller/upsell_customise_controller.dart';
import 'package:mint_bird_app/screens/upsell/widgets/show_color_picker.dart';
import 'package:mint_bird_app/utils/api_utils.dart';
import 'package:mint_bird_app/utils/m_colors.dart';
import 'package:mint_bird_app/utils/templates.dart';
import 'package:mint_bird_app/utils/validator.dart';
import 'package:mint_bird_app/widgets/border_button.dart';
import 'package:mint_bird_app/widgets/custom_buttons.dart';
import 'package:mint_bird_app/widgets/customise_loading.dart';
import 'package:mint_bird_app/widgets/loaders.dart';
import 'package:mint_bird_app/widgets/loading_image.dart';
import 'package:mint_bird_app/widgets/second_textfield.dart';

import '../controller/upsell_controller.dart';

class UpsellCustomiseTab extends StatefulWidget {
  final int selectedTemplate;

  const UpsellCustomiseTab({Key key, this.selectedTemplate}) : super(key: key);

  @override
  _UpsellCustomiseTabState createState() => _UpsellCustomiseTabState();
}

class _UpsellCustomiseTabState extends State<UpsellCustomiseTab> {
  PageController pageController = PageController();
  UpsellController upsellController = Get.put(UpsellController());
  UpsellCustomiseController uCC = Get.put(UpsellCustomiseController());

  @override
  void initState() {
    if (widget.selectedTemplate != 0)
      getUpSellCustomiseDataService(
          template: widget.selectedTemplate.toString());
    upsellController.selectedCheckoutTemplate.value =
        widget.selectedTemplate ?? 0;
    upsellController.customizeTabIndex.value = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(24),
          child: Row(
            children: [
              customTab(title: "Template", index: 0),
              SizedBox(width: 16),
              customTab(title: "Customise", index: 1),
            ],
          ),
        ),
        Container(
          child: Obx(
            () {
              return upsellController.customizeTabIndex.value == 1
                  ? Expanded(
                      child: Stack(
                      children: [
                        InAppWebView(
                          onProgressChanged: (controller, value) {
                            print(value);
                            upsellController.upsellLoads.value =
                                (value / 100).toDouble();
                          },
                          initialUrlRequest: URLRequest(
                              url: Uri.parse(
                                  "https://app.mintbird.com/customize-iframe/upsell/${upsellController.upSellId.value}")),
                        ),
                        upsellController.upsellLoads.value == 1.0
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
                                            color:
                                                Colors.black.withOpacity(0.16),
                                            offset: Offset(2, 2),
                                            blurRadius: 6)
                                      ]),
                                  child: LiquidCircularProgressIndicator(
                                    center: Text(
                                      "${((upsellController.upsellLoads.value) * 100)}",
                                      style: TextStyle(
                                          color: ((upsellController.upsellLoads
                                                              .value) *
                                                          100)
                                                      .ceil() >
                                                  50
                                              ? Colors.white
                                              : mPrimaryColor1),
                                    ),
                                    value: upsellController.upsellLoads.value,
                                    backgroundColor: Colors.white,
                                    direction: Axis.vertical,
                                    valueColor:
                                        AlwaysStoppedAnimation(mPrimaryColor),
                                  ),
                                ),
                              ),
                      ],
                    ))
                  : authController.loading.value
                      ? Expanded(
                          child: templatesLoading(upsellTemplates.length))
                      : Expanded(
                          child: GridView.builder(
                            physics: BouncingScrollPhysics(),
                            itemCount: upsellTemplates.length,
                            padding: EdgeInsets.only(
                                left: 24, right: 24, bottom: 24),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 24,
                              mainAxisSpacing: 24,
                              childAspectRatio: 0.6,
                            ),
                            itemBuilder: (context, index) {
                              return InkWell(
                                splashColor: mPurple,
                                onTap: () {
                                  upsellController.selectedCheckoutTemplate
                                      .value = index + 1;
                                  setUpSellTemplate(template: index + 1);
                                },
                                child: Obx(
                                  () {
                                    return Stack(
                                      fit: StackFit.loose,
                                      alignment: Alignment.bottomRight,
                                      children: [
                                        Container(
                                          height: 400,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(6),
                                            border: upsellController
                                                        .selectedCheckoutTemplate
                                                        .value ==
                                                    index + 1
                                                ? Border.all(
                                                    color: mBtnColor,
                                                    width: 2,
                                                  )
                                                : null,
                                          ),
                                          child: loadingImage(
                                            upsellTemplates[index],
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        upsellController
                                                    .selectedCheckoutTemplate
                                                    .value ==
                                                index + 1
                                            ? Container(
                                                padding: EdgeInsets.all(5),
                                                decoration: BoxDecoration(
                                                  color: mBtnColor,
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    bottomRight:
                                                        Radius.circular(
                                                      6,
                                                    ),
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
                                  },
                                ),
                              );
                            },
                          ),
                        );
            },
          ),
        ),
      ],
    );
  }

  Widget oldCustomise() {
    return Expanded(
        child: Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: SingleChildScrollView(
        child: Column(
          children: [
            uCC.uCData.value.pickYourPrimaryTemplateColor == 1
                ? editorContainer(
                    active: true,
                    height: 37.67,
                    child: widget1("PICK YOUR PRIMARY TEMPLATE COLOR"),
                    switchData: Container(
                      height: 45,
                      width: 45,
                      margin: EdgeInsets.only(right: 16),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.white, width: 2),
                          color: uCC.pickerColor.value,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black12,
                                offset: Offset(4, 4),
                                blurRadius: 10)
                          ],
                          shape: BoxShape.circle),
                    ),
                    onTap: () {
                      showColorPicker(onSet: () {
                        saveColorInTemplate(uCC.pickerColor.value
                            .toString()
                            .replaceAll("Color(0xff", "#")
                            .replaceAll(")", ""));
                      });
                    })
                : SizedBox(),
            uCC.uCData.value.editNavigationBar == 1
                ? editorContainer(
                    height: 37.67,
                    active: upsellController.isNavigationBar.value,
                    child: widget1("EDIT NAVIGATION BAR"),
                    switchData: Switch(
                        value: upsellController.isNavigationBar.value,
                        onChanged: (value) {
                          upsellController.isNavigationBar.value = value;
                          saveUpsellCustomiseTemplate(
                              modalName: "navigation_bar",
                              navigationBar: value ? "1" : "0");
                        }),
                    onTap: () {
                      if (upsellController.isNavigationBar.value) {
                        editNavigationBar();
                      }
                    })
                : SizedBox(),
            uCC.uCData.value.editHeader == 1
                ? editorContainer(
                    active: upsellController.isHeader.value,
                    height: 37.67,
                    child: widget1("EDIT HEADER"),
                    switchData: Switch(
                        value: upsellController.isHeader.value,
                        onChanged: (value) {
                          upsellController.isHeader.value = value;
                          saveUpsellCustomiseTemplate(
                              modalName: "header", header: value ? "1" : "0");
                        }),
                    onTap: () {
                      if (upsellController.isHeader.value) {
                        editHeader();
                      }
                    })
                : SizedBox(),
            uCC.uCData.value.editVideo == 1
                ? editorContainer(
                    active: upsellController.isVideo.value,
                    height: 37.67,
                    child: widget1("EDIT VIDEO"),
                    switchData: Switch(
                        value: upsellController.isVideo.value,
                        onChanged: (value) {
                          upsellController.isVideo.value = value;
                          saveUpsellCustomiseTemplate(
                              modalName: "video", video: value ? "1" : "0");
                        }),
                    onTap: () {
                      if (upsellController.isVideo.value) {
                        editVideo();
                      }
                    })
                : SizedBox(),
            uCC.uCData.value.editDescriptionText == 1
                ? editorContainer(
                    height: 37.67,
                    active: upsellController.isDescription.value,
                    child: widget1("EDIT DESCRIPTION TEXT"),
                    switchData: Switch(
                        value: upsellController.isDescription.value,
                        onChanged: (value) {
                          upsellController.isDescription.value = value;
                          saveUpsellCustomiseTemplate(
                              modalName: "description_text",
                              descriptionText: value ? "1" : "0");
                        }),
                    onTap: () {
                      if (upsellController.isDescription.value) {
                        editDescription();
                      }
                    })
                : SizedBox(),
            uCC.uCData.value.editUpgradeText == 1
                ? editorContainer(
                    height: 37.67,
                    active: upsellController.isUpgrade.value,
                    child: widget1("EDIT UPGRADE TEXT"),
                    switchData: Switch(
                        value: upsellController.isUpgrade.value,
                        onChanged: (value) {
                          upsellController.isUpgrade.value = value;
                          saveUpsellCustomiseTemplate(
                              modalName: "upgrade_text",
                              upgradeText: value ? "1" : "0");
                        }),
                    onTap: () {
                      if (upsellController.isUpgrade.value) {
                        editUpgrade();
                      }
                    })
                : SizedBox(),
            uCC.uCData.value.editFooterLogo == 1
                ? editorContainer(
                    height: 37.67,
                    active: upsellController.isFooterLogo.value,
                    child: widget1("EDIT FOOTER LOGO"),
                    switchData: Switch(
                        value: upsellController.isFooterLogo.value,
                        onChanged: (value) {
                          upsellController.isFooterLogo.value = value;
                          saveUpsellCustomiseTemplate(
                              modalName: "footer_logo",
                              footerLogo: value ? "1" : "0");
                        }),
                    onTap: () {})
                : SizedBox(),
            uCC.uCData.value.editCopyright == 1
                ? editorContainer(
                    height: 37.67,
                    active: upsellController.isCopyRight.value,
                    child: widget1("EDIT COPYRIGHT"),
                    switchData: Switch(
                        value: upsellController.isCopyRight.value,
                        onChanged: (value) {
                          upsellController.isCopyRight.value = value;
                          saveUpsellCustomiseTemplate(
                              modalName: "copyright",
                              copyRight: value ? "1" : "0");
                        }),
                    onTap: () {
                      if (upsellController.isCopyRight.value) {
                        editCopyRight();
                      }
                    })
                : SizedBox(),
            uCC.uCData.value.editWaitAMinuteText == 1
                ? editorContainer(
                    height: 37.67,
                    active: upsellController.isWaitAMinuteText.value,
                    child: widget1("EDIT WAIT A MINUTE"),
                    switchData: Switch(
                        value: upsellController.isWaitAMinuteText.value,
                        onChanged: (value) {
                          upsellController.isWaitAMinuteText.value = value;
                          saveUpsellCustomiseTemplate(
                              modalName: "wait_a_minute",
                              waitAMinute: value ? "1" : "0");
                        }),
                    onTap: () {
                      if (upsellController.isWaitAMinuteText.value) {
                        editWaitAMinute();
                      }
                    })
                : SizedBox(),
            uCC.uCData.value.editGetInstantButtonText == 1
                ? editorContainer(
                    height: 37.67,
                    active: upsellController.isGetInstantButton.value,
                    child: widget1("EDIT GET INSTANT BUTTON"),
                    switchData: Switch(
                        value: upsellController.isGetInstantButton.value,
                        onChanged: (value) {
                          upsellController.isGetInstantButton.value = value;
                          saveUpsellCustomiseTemplate(
                              modalName: "instant_button",
                              instantButton: value ? "1" : "0");
                        }),
                    onTap: () {
                      if (upsellController.isGetInstantButton.value) {
                        editInstantButton();
                      }
                    })
                : SizedBox(),
            uCC.uCData.value.editSpacialOfferText == 1
                ? editorContainer(
                    height: 37.67,
                    active: upsellController.isSpecialOfferText.value,
                    child: widget1("EDIT SPECIAL OFFER"),
                    switchData: Switch(
                        value: upsellController.isSpecialOfferText.value,
                        onChanged: (value) {
                          upsellController.isSpecialOfferText.value = value;
                          saveUpsellCustomiseTemplate(
                              modalName: "special_offer",
                              offer: value ? "1" : "0");
                        }),
                    onTap: () {
                      if (upsellController.isSpecialOfferText.value) {
                        editSpecialOffer();
                      }
                    })
                : SizedBox(),
            uCC.uCData.value.editCenterContent == 1
                ? editorContainer(
                    height: 37.67,
                    active: upsellController.isCenterContent.value,
                    child: widget1("EDIT CENTER CONTENT"),
                    switchData: Switch(
                        value: upsellController.isCenterContent.value,
                        onChanged: (value) {
                          upsellController.isCenterContent.value = value;
                          saveUpsellCustomiseTemplate(
                              modalName: "center_content",
                              centerContent: value ? "1" : "0");
                        }),
                    onTap: () {
                      if (upsellController.isCenterContent.value) {
                        editCenterContent();
                      }
                    })
                : SizedBox(),
            uCC.uCData.value.editLifitimeText == 1
                ? editorContainer(
                    height: 37.67,
                    active: upsellController.isLifeTimeText.value,
                    child: widget1("EDIT LIFETIME"),
                    switchData: Switch(
                        value: upsellController.isLifeTimeText.value,
                        onChanged: (value) {
                          upsellController.isLifeTimeText.value = value;
                          saveUpsellCustomiseTemplate(
                              modalName: "lifetime_text",
                              lifeTime: value ? "1" : "0");
                        }),
                    onTap: () {
                      if (upsellController.isLifeTimeText.value) {
                        editLifeTime();
                      }
                    })
                : SizedBox(),
            uCC.uCData.value.editOtoBlock == 1
                ? editorContainer(
                    height: 37.67,
                    active: upsellController.isOtoBlock.value,
                    child: widget1("EDIT OTO BLOCK"),
                    switchData: Switch(
                        value: upsellController.isOtoBlock.value,
                        onChanged: (value) {
                          upsellController.isOtoBlock.value = value;
                          saveUpsellCustomiseTemplate(
                              modalName: "oto", oto: value ? "1" : "0");
                        }),
                    onTap: () {
                      if (upsellController.isOtoBlock.value) {
                        editOtoBlock();
                      }
                    })
                : SizedBox(),
            uCC.uCData.value.editOneTimeOnlyOfferText == 1
                ? editorContainer(
                    height: 37.67,
                    active: upsellController.isOneTimeOnlyOfferText.value,
                    child: widget1("EDIT ONE TIME ONLY OFFER"),
                    switchData: Switch(
                        value: upsellController.isOneTimeOnlyOfferText.value,
                        onChanged: (value) {
                          upsellController.isOneTimeOnlyOfferText.value = value;
                          saveUpsellCustomiseTemplate(
                              modalName: "one_time_only_offer",
                              oneTimeOnlyOffer: value ? "1" : "0");
                        }),
                    onTap: () {})
                : SizedBox(),
            uCC.uCData.value.editImage == 1
                ? editorContainer(
                    height: 37.67,
                    active: upsellController.isImage.value,
                    child: widget1("EDIT IMAGE"),
                    switchData: Switch(
                        value: upsellController.isImage.value,
                        onChanged: (value) {
                          upsellController.isImage.value = value;
                          saveUpsellCustomiseTemplate(
                              modalName: "one_time_image",
                              oneTimeImage: value ? "1" : "0");
                        }),
                    onTap: () {
                      editImages();
                    })
                : SizedBox(),
            uCC.uCData.value.editTimer == 1
                ? editorContainer(
                    height: 37.67,
                    active: upsellController.isTimer.value,
                    child: widget1("EDIT TIMER"),
                    switchData: Switch(
                        value: upsellController.isTimer.value,
                        onChanged: (value) {
                          upsellController.isTimer.value = value;
                          saveUpsellCustomiseTemplate(
                              modalName: "timer", timer: value ? "1" : "0");
                        }),
                    onTap: () {
                      // editVideo();
                    })
                : SizedBox(),
            uCC.uCData.value.editBullets == 1
                ? editorContainer(
                    height: 37.67,
                    active: upsellController.isBullets.value,
                    child: widget1("EDIT BULLETS"),
                    switchData: Switch(
                        value: upsellController.isBullets.value,
                        onChanged: (value) {
                          upsellController.isBullets.value = value;

                          saveUpsellCustomiseTemplate(
                              modalName: "bullets", bullets: value ? "1" : "0");
                        }),
                    onTap: () {
                      if (upsellController.isBullets.value) {
                        editBullets();
                      }
                    })
                : SizedBox(),
            uCC.uCData.value.editOtoButton == 1
                ? editorContainer(
                    height: 37.67,
                    active: upsellController.isOto.value,
                    child: widget1("EDIT OTO BUTTON"),
                    switchData: Switch(
                        value: upsellController.isOto.value,
                        onChanged: (value) {
                          upsellController.isOto.value = value;

                          saveUpsellCustomiseTemplate(
                              modalName: "oto", oto: value ? "1" : "0");
                        }),
                    onTap: () {
                      if (upsellController.isOto.value) {
                        editOto();
                      }
                    })
                : SizedBox(),
            uCC.uCData.value.editOtoButton == 1
                ? editorContainer(
                    height: 37.67,
                    active: upsellController.isBanner.value,
                    child: widget1("EDIT BANNER"),
                    switchData: Switch(
                        value: upsellController.isBanner.value,
                        onChanged: (value) {
                          upsellController.isBanner.value = value;
                          // saveUpsellCustomiseTemplate(
                          //     modalName: "oto",
                          //     oto: value ? "1" : "0");
                        }),
                    onTap: () {
                      if (upsellController.isBanner.value) {
                        editBanner();
                      }
                    })
                : SizedBox(),
            uCC.uCData.value.editThankYouButton == 1
                ? editorContainer(
                    height: 37.67,
                    active: upsellController.isThankYou.value,
                    child: widget1("EDIT THANK YOU BUTTON"),
                    switchData: Switch(
                        value: upsellController.isThankYou.value,
                        onChanged: (value) {
                          upsellController.isThankYou.value = value;

                          saveUpsellCustomiseTemplate(
                              modalName: "thank_you",
                              thankYou: value ? "1" : "0");
                        }),
                    onTap: () {
                      if (upsellController.isThankYou.value) {
                        editThankYou();
                      }
                    })
                : SizedBox(),
          ],
        ),
      ),
    ));
  }

  Widget customTab({String title, int index}) {
    return Expanded(
      child: Obx(
        () {
          return InkWell(
            onTap: () {
              upsellController.customizeTabIndex.value = index;
              if (index == 1) upsellController.upsellLoads.value = 0.0;
              // getUpSellDownSellTemplateService(
              //   type: "upsell",
              // );
            },
            child: AnimatedContainer(
              duration: Duration(milliseconds: 300),
              padding: EdgeInsets.symmetric(vertical: 10),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: upsellController.customizeTabIndex.value == index
                    ? mlightPurple
                    : Colors.white,
                border: Border.all(
                  color: upsellController.customizeTabIndex.value == index
                      ? mPurple
                      : mTextboxTitleColor,
                  width: 2,
                ),
              ),
              child: Text(
                title,
                style: GoogleFonts.inter(
                  color: upsellController.customizeTabIndex.value == index
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

  editNavigationBar() {
    final GlobalKey<FormState> _editCartFormKey = GlobalKey<FormState>();

    editDialog(
        title: "Add navigation to your template",
        onSave: () {
          if (_editCartFormKey.currentState.validate()) {
            saveUpsellCustomiseTemplate(
                    templateEditType: "edit_navigation_bar",
                    funnelNavigationOne: uCC.noticeBarController.value.text)
                .then((value) {
              Get.back();
            });
          }
        },
        body: Form(
          key: _editCartFormKey,
          child: Obx(() {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                textFieldTitle("Notice message"),
                SecondTextField(
                  controller: uCC.noticeBarController.value,
                  hintText: "Notice message",
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

  editHeader() {
    final GlobalKey<FormState> _editHeaderFormKey = GlobalKey<FormState>();

    editDialog(
        title: "Add header to your template",
        onSave: () {
          if (_editHeaderFormKey.currentState.validate()) {
            saveUpsellCustomiseTemplate(
                    templateEditType: "edit_header",
                    funnelHeaderOne: uCC.headerTitleController.value.text,
                    funnelHeaderTwo: uCC.headerDescController.value.text)
                .then((value) {
              Get.back();
            });
          }
        },
        body: Form(
          key: _editHeaderFormKey,
          child: Obx(() {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                textFieldTitle("Header title"),
                SecondTextField(
                  controller: uCC.headerTitleController.value,
                  hintText: "Header title",
                  enabled: true,
                  obscureText: false,
                  validator: (val) {
                    return FieldValidator.validateValueIsEmpty(val);
                  },
                ),
                textFieldTitle("Header description"),
                SecondTextField(
                  controller: uCC.headerDescController.value,
                  hintText: "Header description",
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

  editImages() {
    editDialog(
        title: "Image Editor",
        onSave: () {
          // sendImageInTemplate(templateEditType: "edit_image");
        },
        body: InkWell(
          onTap: () async {
            List<Media> res = await ImagesPicker.pick(
              count: 1,
              pickType: PickType.image,
            );
            if (res != null) {
              uCC.imagePath.value = res.first.path;
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
                    return uCC.imagePath.value != null
                        ? uCC.imagePath.value.contains(APIUtils.imageBaseUrl)
                            ? loadingImage(uCC.imagePath.value,
                                height: 200,
                                width: double.infinity,
                                fit: BoxFit.contain)
                            : Image(
                                image: FileImage(
                                  File(uCC.imagePath.value),
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

  editBanner() {
    editDialog(
        title: "Banner Editor",
        onSave: () {
          // sendImageInTemplate(templateEditType: "edit_image");
        },
        body: InkWell(
          onTap: () async {
            List<Media> res = await ImagesPicker.pick(
              count: 1,
              pickType: PickType.image,
            );
            if (res != null) {
              uCC.bannerImagePath.value = res.first.path;
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
              child: Column(
                children: [
                  Stack(
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
                        return uCC.bannerImagePath.value != null
                            ? uCC.bannerImagePath.value
                                    .contains(APIUtils.imageBaseUrl)
                                ? loadingImage(uCC.bannerImagePath.value,
                                    height: 200,
                                    width: double.infinity,
                                    fit: BoxFit.contain)
                                : Image(
                                    image: FileImage(
                                      File(uCC.bannerImagePath.value),
                                    ),
                                    height: 200,
                                    width: double.infinity,
                                    fit: BoxFit.contain,
                                  )
                            : SizedBox();
                      })
                    ],
                  ),
                  textFieldTitle("Choose background color"),
                  Container(
                    child: Row(
                      children: [
                        Text("Choose background color"),
                        Container(
                          height: 30,
                          width: 30,
                          color: Colors.redAccent,
                        ),
                      ],
                    ),
                  ),
                ],
              )),
        ));
  }

  editBullets() {
    UpsellCustomiseController uCC = Get.put(UpsellCustomiseController());
    final GlobalKey<FormState> _editBulletFormKey = GlobalKey<FormState>();
    TextEditingController nameController = TextEditingController();
    TextEditingController messageController = TextEditingController();
    editDialog(
        title: "Bullet Editor",
        onSave: () {
          sendImageInUpsellTemplate(
              templateEditType: "edit_bullets",
              bulletList: uCC.bulletList,
              funnelBulletTitle: uCC.bulletHeadlineController.value.text);
        },
        body: Form(
          key: _editBulletFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(() {
                return SecondTextField(
                  controller: uCC.bulletHeadlineController.value,
                  hintText: "Edit headline",
                  enabled: true,
                  obscureText: false,
                );
              }),
              Row(
                children: [
                  InkWell(
                    onTap: () async {
                      List<Media> res = await ImagesPicker.pick(
                        count: 1,
                        pickType: PickType.image,
                      );
                      if (res != null) {
                        uCC.bulletImagePath.value = res.first.path;
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
                              return uCC.bulletImagePath.value.length > 0
                                  ? Image(
                                      image: FileImage(
                                        File(uCC.bulletImagePath.value),
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
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.only(top: 10),
                      height: 115,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    ),
                  )
                ],
              ),
              Obx(() {
                return uCC.bulletList.length == 0
                    ? Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 15),
                          child: Text("No testimonial added"),
                        ),
                      )
                    : ListView.builder(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        shrinkWrap: true,
                        itemCount: uCC.bulletList.length,
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
                                      return uCC.bulletList[index]["image"] !=
                                              null
                                          ? loadingImage(
                                              uCC.bulletList[index]["image"],
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
                                      uCC.bulletList[index]["name"],
                                      style: TextStyle(fontSize: 16),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Text(
                                      uCC.bulletList[index]["msg"],
                                      overflow: TextOverflow.ellipsis,
                                    )
                                  ],
                                )),
                                IconButton(
                                    onPressed: () {
                                      uCC.bulletList.removeAt(index);
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
                      uCC.bulletList.add({
                        "name": nameController.text,
                        "msg": messageController.text,
                        "image": uCC.bulletImagePath.value
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

  editVideo() {
    final GlobalKey<FormState> _editVideoFormKey = GlobalKey<FormState>();

    editDialog(
        title: "Add a video to show off your product",
        onSave: () {
          if (_editVideoFormKey.currentState.validate()) {
            saveUpsellCustomiseTemplate(
              templateEditType: "edit_video",
              funnelVideoOne: uCC.videoController.value.text,
            ).then((value) {
              Get.back();
            });
          }
        },
        body: Form(
          key: _editVideoFormKey,
          child: Obx(() {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                textFieldTitle("Header title"),
                SecondTextField(
                  maxline: 4,
                  controller: uCC.videoController.value,
                  hintText: "Enter your video embed code here",
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

  editOto() {
    final GlobalKey<FormState> _editOtoFormKey = GlobalKey<FormState>();

    editDialog(
        title: "Edit OTO button to your template",
        onSave: () {
          if (_editOtoFormKey.currentState.validate()) {
            saveUpsellCustomiseTemplate(
              templateEditType: "edit_oto",
              funnelButtonOne: uCC.otoController.value.text,
            ).then((value) {
              Get.back();
            });
          }
        },
        body: Form(
          key: _editOtoFormKey,
          child: Obx(() {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                textFieldTitle("OTO Button"),
                SecondTextField(
                  controller: uCC.otoController.value,
                  hintText: "Yes add to my order",
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

  editThankYou() {
    final GlobalKey<FormState> _editThankYouFormKey = GlobalKey<FormState>();

    editDialog(
        title: "Edit thank you button to your template",
        onSave: () {
          if (_editThankYouFormKey.currentState.validate()) {
            saveUpsellCustomiseTemplate(
              templateEditType: "edit_thankyou",
              funnelButtonTwo: uCC.thankYouController.value.text,
            ).then((value) {
              Get.back();
            });
          }
        },
        body: Form(
          key: _editThankYouFormKey,
          child: Obx(() {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                textFieldTitle("Thank you Button"),
                SecondTextField(
                  controller: uCC.thankYouController.value,
                  hintText: "Thank you button name",
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

  editWaitAMinute() {
    final GlobalKey<FormState> _editWaitAMinuteFormKey = GlobalKey<FormState>();

    editDialog(
        title: "Add wait a minute text to your template",
        onSave: () {
          if (_editWaitAMinuteFormKey.currentState.validate()) {
            saveUpsellCustomiseTemplate(
                    templateEditType: "edit_wait_minute_text",
                    funnelWaitAMinuteTextOne:
                        uCC.waitAMinuteController.value.text)
                .then((value) {
              Get.back();
            });
          }
        },
        body: Form(
          key: _editWaitAMinuteFormKey,
          child: Obx(() {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10,
                ),
                SecondTextField(
                  controller: uCC.waitAMinuteController.value,
                  hintText: "Wait a minute!",
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

  editDescription() {
    final GlobalKey<FormState> _editDescriptionFormKey = GlobalKey<FormState>();

    editDialog(
        title: "Add description text to your template",
        onSave: () {
          if (_editDescriptionFormKey.currentState.validate()) {
            saveUpsellCustomiseTemplate(
                    templateEditType: "edit_description_text",
                    funnelNavigationOne: uCC.descriptionController.value.text)
                .then((value) {
              Get.back();
            });
          }
        },
        body: Form(
          key: _editDescriptionFormKey,
          child: Obx(() {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10,
                ),
                SecondTextField(
                  controller: uCC.descriptionController.value,
                  hintText: "Click here to process to day 1",
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

  editUpgrade() {
    final GlobalKey<FormState> _editUpgradeFormKey = GlobalKey<FormState>();

    editDialog(
        title: "Add upgrade text to your template",
        onSave: () {
          if (_editUpgradeFormKey.currentState.validate()) {
            saveUpsellCustomiseTemplate(
                    templateEditType: "edit_upgrade_text",
                    funnelUpgradeText1: uCC.upgradeController.value.text)
                .then((value) {
              Get.back();
            });
          }
        },
        body: Form(
          key: _editUpgradeFormKey,
          child: Obx(() {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10,
                ),
                SecondTextField(
                  controller: uCC.upgradeController.value,
                  hintText: "Upgrade your membership",
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

  editCopyRight() {
    final GlobalKey<FormState> _editCopyRightFormKey = GlobalKey<FormState>();

    editDialog(
        title: "Add copyright text to your template",
        onSave: () {
          if (_editCopyRightFormKey.currentState.validate()) {
            saveUpsellCustomiseTemplate(
                    templateEditType: "edit_copyright_text",
                    funnelCopyrightText1: uCC.copyRightController.value.text)
                .then((value) {
              Get.back();
            });
          }
        },
        body: Form(
          key: _editCopyRightFormKey,
          child: Obx(() {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10,
                ),
                SecondTextField(
                  controller: uCC.copyRightController.value,
                  hintText: "Copyright 2021 - Live Webinar - Copyright 2021",
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

  editInstantButton() {
    final GlobalKey<FormState> _editInstantButtonFormKey =
        GlobalKey<FormState>();

    editDialog(
        title: "Add instant button text to your template",
        onSave: () {
          if (_editInstantButtonFormKey.currentState.validate()) {
            saveUpsellCustomiseTemplate(
                    templateEditType: "edit_instant_button_text",
                    funnelInstantButtonOne:
                        uCC.instantButtonController.value.text)
                .then((value) {
              Get.back();
            });
          }
        },
        body: Form(
          key: _editInstantButtonFormKey,
          child: Obx(() {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10,
                ),
                SecondTextField(
                  controller: uCC.instantButtonController.value,
                  hintText: "Get instant access now!",
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

  editSpecialOffer() {
    final GlobalKey<FormState> _editSpecialOfferFormKey =
        GlobalKey<FormState>();

    editDialog(
        title: "Add offer text to your template",
        onSave: () {
          if (_editSpecialOfferFormKey.currentState.validate()) {
            saveUpsellCustomiseTemplate(
                    templateEditType: "edit_offer_text",
                    funnelOfferTextOne: uCC.specialOfferController.value.text)
                .then((value) {
              Get.back();
            });
          }
        },
        body: Form(
          key: _editSpecialOfferFormKey,
          child: Obx(() {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10,
                ),
                SecondTextField(
                  controller: uCC.specialOfferController.value,
                  hintText: "Special offer! Hurry up.",
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

  editCenterContent() {
    final GlobalKey<FormState> _editCenterContentFormKey =
        GlobalKey<FormState>();

    editDialog(
        title: "Add center content to your template",
        onSave: () {
          if (_editCenterContentFormKey.currentState.validate()) {
            saveUpsellCustomiseTemplate(
                    templateEditType: "edit_center_text",
                    funnelCenterTitleOne:
                        uCC.centerContent1Controller.value.text,
                    funnelCenterDescriptionOne:
                        uCC.centerContent2Controller.value.text)
                .then((value) {
              Get.back();
            });
          }
        },
        body: Form(
          key: _editCenterContentFormKey,
          child: Obx(() {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10,
                ),
                SecondTextField(
                  controller: uCC.centerContent1Controller.value,
                  hintText: "Yes i want to join funnel training",
                  enabled: true,
                  obscureText: false,
                  validator: (val) {
                    return FieldValidator.validateValueIsEmpty(val);
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                SecondTextField(
                  controller: uCC.centerContent2Controller.value,
                  hintText: "Gain instant access to all course",
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

  editOtoBlock() {
    final GlobalKey<FormState> _editOtoBlockFormKey = GlobalKey<FormState>();

    editDialog(
        title: "Edit OTO block text to your template",
        onSave: () {
          if (_editOtoBlockFormKey.currentState.validate()) {
            saveUpsellCustomiseTemplate(
                    templateEditType: "edit_oto_three",
                    funnelOtoButtonOne: uCC.otoBlock1Controller.value.text,
                    funnelOtoButtonDescriptionOne:
                        uCC.otoBlock2Controller.value.text)
                .then((value) {
              Get.back();
            });
          }
        },
        body: Form(
          key: _editOtoBlockFormKey,
          child: Obx(() {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10,
                ),
                SecondTextField(
                  controller: uCC.otoBlock1Controller.value,
                  hintText: "Yes i want to join funnel training",
                  enabled: true,
                  obscureText: false,
                  validator: (val) {
                    return FieldValidator.validateValueIsEmpty(val);
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                SecondTextField(
                  controller: uCC.otoBlock2Controller.value,
                  hintText: "Clicking here will add to your order immediately",
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

  editLifeTime() {
    final GlobalKey<FormState> _editLifeTimeFormKey = GlobalKey<FormState>();

    editDialog(
        title: "Add lifetime text to your template",
        onSave: () {
          if (_editLifeTimeFormKey.currentState.validate()) {
            saveUpsellCustomiseTemplate(
                    templateEditType: "edit_lifetime_text",
                    funnelLifetimeTextOne: uCC.lifeTimeController.value.text)
                .then((value) {
              Get.back();
            });
          }
        },
        body: Form(
          key: _editLifeTimeFormKey,
          child: Obx(() {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10,
                ),
                SecondTextField(
                  controller: uCC.lifeTimeController.value,
                  hintText: "Just \$67 a month get lifetime access",
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

  Widget widget1(String title) {
    return Text(
      title,
      style: getDefaultTextStyle(12, Color(0xff00A3F5),
          fontweight: FontWeight.bold),
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
      margin: EdgeInsets.only(bottom: 16),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          splashColor: Colors.blueAccent.withOpacity(0.3),
          onTap: onTap,
          child: Container(
            child: DottedBorder(
              color: active
                  ? Color(0xff86cdff)
                  : Colors.grey[300], //color of dotted/dash line
              strokeWidth: 1, //thickness of dash/dots
              dashPattern: [5, 5],
              child: Container(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  width: Get.width,
                  // decoration: BoxDecoration(color: Color(0xffD8EDFC)),
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
      ),
    );
  }
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
