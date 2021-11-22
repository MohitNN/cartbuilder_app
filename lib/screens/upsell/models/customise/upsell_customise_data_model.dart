class UpsellTemplateCustomiseData {
  bool status;
  int code;
  Response response;

  UpsellTemplateCustomiseData({this.status, this.code, this.response});

  UpsellTemplateCustomiseData.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code'];
    response = json['response'] != null
        ? new Response.fromJson(json['response'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['code'] = this.code;
    if (this.response != null) {
      data['response'] = this.response.toJson();
    }
    return data;
  }
}

class Response {
  int pickYourPrimaryTemplateColor;
  int editNavigationBar;
  int editHeader;
  int editVideo;
  int editBullets;
  int editOtoButton;
  int editThankYouButton;
  int editDescriptionText;
  int editUpgradeText;
  int editFooterLogo;
  int editCopyright;
  int editWaitAMinuteText;
  int editGetInstantButtonText;
  int editSpacialOfferText;
  int editCenterContent;
  int editLifitimeText;
  int editOtoBlock;
  int editOneTimeOnlyOfferText;
  int editImage;
  int editGetInstantSectionText;
  int editOfferText;
  int editTimer;

  Response(
      {this.pickYourPrimaryTemplateColor,
      this.editNavigationBar,
      this.editHeader,
      this.editVideo,
      this.editBullets,
      this.editOtoButton,
      this.editThankYouButton,
      this.editDescriptionText,
      this.editUpgradeText,
      this.editFooterLogo,
      this.editCopyright,
      this.editWaitAMinuteText,
      this.editGetInstantButtonText,
      this.editSpacialOfferText,
      this.editCenterContent,
      this.editLifitimeText,
      this.editOtoBlock,
      this.editOneTimeOnlyOfferText,
      this.editImage,
      this.editGetInstantSectionText,
      this.editOfferText,
      this.editTimer});

  Response.fromJson(Map<String, dynamic> json) {
    pickYourPrimaryTemplateColor = json['Pick_your_primary_template_color'];
    editNavigationBar = json['edit_navigation bar'];
    editHeader = json['edit_header'];
    editVideo = json['edit_video'];
    editBullets = json['edit_bullets'];
    editOtoButton = json['edit_oto_button'];
    editThankYouButton = json['edit_thank_you_button'];
    editDescriptionText = json['edit_description_text'];
    editUpgradeText = json['edit_upgrade_text'];
    editFooterLogo = json['edit_footer_logo'];
    editCopyright = json['edit_copyright'];
    editWaitAMinuteText = json['edit_wait_a_minute_text'];
    editGetInstantButtonText = json['edit_get_instant_button_text'];
    editSpacialOfferText = json['edit_spacial_offer_text'];
    editCenterContent = json['edit_center_content'];
    editLifitimeText = json['edit_lifitime_text'];
    editOtoBlock = json['edit_oto_block'];
    editOneTimeOnlyOfferText = json['edit_one_time_only_offer_text'];
    editImage = json['edit_image'];
    editGetInstantSectionText = json['edit_get instant_section_text'];
    editOfferText = json['edit_offer_text'];
    editTimer = json['edit_timer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Pick_your_primary_template_color'] =
        this.pickYourPrimaryTemplateColor;
    data['edit_navigation bar'] = this.editNavigationBar;
    data['edit_header'] = this.editHeader;
    data['edit_video'] = this.editVideo;
    data['edit_bullets'] = this.editBullets;
    data['edit_oto_button'] = this.editOtoButton;
    data['edit_thank_you_button'] = this.editThankYouButton;
    data['edit_description_text'] = this.editDescriptionText;
    data['edit_upgrade_text'] = this.editUpgradeText;
    data['edit_footer_logo'] = this.editFooterLogo;
    data['edit_copyright'] = this.editCopyright;
    data['edit_wait_a_minute_text'] = this.editWaitAMinuteText;
    data['edit_get_instant_button_text'] = this.editGetInstantButtonText;
    data['edit_spacial_offer_text'] = this.editSpacialOfferText;
    data['edit_center_content'] = this.editCenterContent;
    data['edit_lifitime_text'] = this.editLifitimeText;
    data['edit_oto_block'] = this.editOtoBlock;
    data['edit_one_time_only_offer_text'] = this.editOneTimeOnlyOfferText;
    data['edit_image'] = this.editImage;
    data['edit_get instant_section_text'] = this.editGetInstantSectionText;
    data['edit_offer_text'] = this.editOfferText;
    data['edit_timer'] = this.editTimer;
    return data;
  }
}
