class APIUtils {
  static String baseUrl = "https://app.mintbird.com/api/";
  static String imageBaseUrl =
      "https://app.mintbird.com/user_storage/template_images/";
  static String register = "register";

  static String forgotPassword = "reset-password";
  static String login = "login";
  static String getUserConnectedAccount = "user/get_user_connected_accounts";
  static String getUserDetail = "user";
  static String saveTypeOfDelivery = "user/save_type_of_delivery";

  ///FUNNEL
  static String createFunnel = "user/create_funnel";
  static String getFunnel = "user/get_user_funnels";
  static String getFunnelList = "user/funnel_data_list";
  static String updateFunnel = "user/funnel/update_funnel_detail";
  static String updateFunnelProducts = "user/update_funnel_products";
  static String getUpsellList = "user/upsell_list";
  static String getDownSellList = "user/downsell_list";
  static String getSingleFunnelProduct = "user/get_single_funnel_product/";
  static String updateFunnelFlow = "user/update_funnel_products";
  static String deleteFunnel = "user/delete_funnel/";
  static String funnelImageBaseUrl =
      "https://app.mintbird.com/user_storage/funnel_images/";

  /// PRODUCT
  static String createProduct = "user/create_product";
  static String getProducts = "user/get_user_products2";
  static String getFavoriteProduct = "user/favorite-product";
  static String getRecentProduct = "user/get_recent_product";
  static String getProductDetails = "user/product/";
  static String getProductGroupsDetails = "user/product_group_list";
  static String updateProductDetails = "user/update_product_detail";
  static String updateProductFunnelStatus = "user/change_product_funnel_status";
  static String productImageBaseUrl =
      "https://app.mintbird.com/user_storage/product_images/";
  static String updatePaymentStatus = "user/update_payment_status";
  static String updateProductStatus = "user/change_product_status/";
  static String updateSuccess = "user/update_success_design";
  static String updateTwoStepForm = "user/change_two_step_form";
  static String deleteOrderForm = "user/delete_product/";

  /// UpSELL
  static String createUpSell = "user/create_upsell";
  static String getUpsellDetails = "user/upsell/";
  static String upSellTrackingScript = "user/update_upsell_advance_settings";
  static String getUpsellGroupsDetails = "user/upsell_group_list";
  static String getUserUpSell = "user/get_user_upsells";
  static String updateUpSellDetails = "user/update_upsell_detail";
  static String getAllUpsell = "user/upsell_list";
  static String getAllDownsell = "user/downsell_list";
  static String upSellImageBaseUrl =
      "https://app.mintbird.com/user_storage/upsell_images/";
  static String deleteUpsell = "user/delete_upsell/";

  /// DownSELL
  static String createDownSell = "user/create_downsell";
  static String getUserDownSell = "user/get_user_downsells";
  static String getDownsellDetails = "user/downsell/";
  static String downSellTrackingScript =
      "user/update_downsell_advance_settings";
  static String updateDownSellDetails = "user/update_downsell_detail";
  static String downSellImageBaseUrl =
      "https://app.mintbird.com/user_storage/downsell_images/";
  static String deleteDownsell = "user/delete_downsell/";

  /// Groups
  static String getProductGroup = "user/product_group_list";
  static String getFunnelGroup = "user/funnel_group_list";
  static String getUpsellGroup = "user/upsell_group_list";
  static String getDownSellGroup = "user/downsell_group_list";
  static String getBumpOfferGroupList = "user/bump_offers_group_list";
  static String getTagList = "user/tag_list_data";
  static String getFunnelProducts = "user/get_single_funnel_product";

  static String getBumpOffer = "user/bump_offers/";
  static String createBumpOffer = "user/saveProductBumpOffer";
  static String getAddedBumpOffer = "user/productAddedBump";
  static String updateCheckoutDesign = "user/update_checkout_design";
  static String getCheckoutDetails = "user/get_template";
  static String saveTemplate = "user/save_template";

  /// Ever Lesson
  static String getChooseAccountList =
      "user/get_connected_membership/everlesson";
  static String getChooseMemberShipList = "user/get_everlesson_membership/";
  static String getChooseLevelList = "user/get_everlesson_access_options/";
  static String getChooseCourseList = "user/get_everlesson_courses/";
  static String getChooseAccessOptionList =
      "user/get_everlesson_access_options/";
  static String saveEverLesson = "user/save_everlesson";

  /// Teachable
  static String getChooseAccountListTeachable =
      "user/get_connected_membership/teachable";
  static String getChooseMemberShipListTeachable =
      "user/get_teachable_membership/";
  static String saveTeachable = "user/save_teachable";

  /// Lifter LMS
  static String getChooseAccountListLifterLMS =
      "user/get_connected_membership/lifterlms";
  static String getChooseCourseListLifterLMS = "user/get_lifter_course/";
  static String getChooseMemberShipListLifterLMS =
      "user/get_lifter_meberships/";
  static String saveLifterLMS = "user/save_lifter";
  static String getUpSellDownSellCustomise = "user/get_funnel_template";
  static String updateUpsSellTemplate = "user/update_upsell_checkout_design";
  static String updateDownsellTemplate = "user/update_downsell_checkout_design";
  static String saveFunnelTemplate = "user/save_funnel_template";
  static String saveColorFunnelTemplate = "user/funnel/set_template_theme";
  static String getTemplateCustomiseData = "user/get_upsell_customize_data/";
  static String bearerToken =
      "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczpcL1wvaW50ZWN5cy5jb21cL2FwaVwvbG9naW4iLCJpYXQiOjE2MjA4MjQ5MjMsImV4cCI6MTYyMDgyODUyMywibmJmIjoxNjIwODI0OTIzLCJqdGkiOiI3d2hFNGRoWkFuUER6a2xpIiwic3ViIjoiNjA5YjU3YWQ5YWIxMTY2N2ViNjUzZDYyIiwicHJ2IjoiMjNiZDVjODk0OWY2MDBhZGIzOWU3MDFjNDAwODcyZGI3YTU5NzZmNyJ9.2225b9OGBXPDedPhj1Zd5nRTDUg6ucr9zwNxYVY_VmM";

  /// PRICING OPTION
  static String createOnetimePricingOption =
      'user/create_onetime_pricing_option';
  static String createSubscriptionPricingOption =
      'user/create_subscription_pricing_option';
  static String createSplitPayPricingOption =
      'user/create_split_pay_pricing_option';
  static String updateOnetimePricingOption =
      'user/update_onetime_pricing_option';
  static String updateSubscriptionPricingOption =
      'user/update_subscription_pricing_option';
  static String updateSplitPayPricingOption =
      'user/update_split_pay_pricing_option';

  /// REPORTING
  static String getDashboard = "user/transactions_data";
  static String getTransaction = "user/transaction";
  static String deleteTransaction = "user/transaction-delete";
  static String transactionDetail = "user/order-data";
  static String updateStatus = "user/order-data/change-status";

  /// PROFILE
  static String updateProfilePicture = "user/update_profile_pic";
  static String updateProfileDetail = "user/update_user_profile";

  /// BUMP OFFER
  static String getBumpOffers = "user/get_user_offers";
  static String getBumpOfferDetail = "user/bump_offers/edit/";
  static String updateBumpOfferDetail = "user/bump_offer/update/";
  static String getDimeSales = "user/get_user_dimesale";
  static String getAllDimeSales = "user/get_user_dimesale_list";
  static String getTimeSales = "user/get_user_timesale";
  static String getAllTimeSales = "user/get_user_timesale_list";
  static String createSingleBumpOffer = "user/bump_offer/create";

  ///DIME_SALE
  static String getDimeSalesGroup = "user/dimesale_group_list";
  static String createDimeSale = "user/create_dimesale";
  static String getDimeSaleDetail = "user/get_single_dimesale/";
  static String getTimeSaleDetail = "user/get_single_timesale/";
  static String updateDimeSale = "user/save-dimesell-theme";
  static String updateDimeSaleProduct = "user/save-product-dimesales";
  static String deleteDimeSale = "user/delete_added_dimesale";

  ///TIME SALES
  static String getTimeSalesGroup = "user/timesale_group_list";
  static String createTimeSale = "user/create_timesale";
  static String updateTimeSale = "user/save-timesale-theme";
  static String updateTimeSaleProduct = "user/save-product-timesales";
  static String deleteTimeSale = "user/delete_added_timesale";

  /// USER TAGS
  static String createTag = "user/tags/create";
  static String updateTag = "user/tags/update";
  static String deleteTag = "user/tag/delete/";
  static String getUserTags = "user/getUserTag";
  static String getUserGroupList = "user/groupList";

  /// Subscriptions
  static String getSubscriptions = "user/subscription-data";
  static String getSubscriptionsList = "user/subscription-data-list";

  /// ScarCity
  static String scarcityProducts = "user/get_added_product_dimesale";
  static String assignScarcityProducts = "user/assignSaleToProduct";
  static String deleteAddedSale = "user/delete_added_sale";
  static String updateScarcityDime = "user/save-dimesell-product-theme";
  static String updateScarcityTime = "user/save-timesell-product-theme";
  static String updateScarcityDimePro = "user/SaveDimeSaleProduct";
  static String updateScarcityTimePro = "user/SaveTimeSaleProduct";

  /// DASHBOARD
  static String getChartData = "user/dashboard/chart";
  static String getAllProduct = "user/product-data-list";
}
