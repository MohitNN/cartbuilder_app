import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mint_bird_app/screens/mange_tags/models/user_group_list_model.dart';
import 'package:mint_bird_app/screens/mange_tags/models/user_tag_list_model.dart';

class ManageTagController extends GetxController {
  RxBool loading = false.obs;
  RxList<UserTag> userTags = [UserTag()].obs;
  RxList<UserGroup> userGroupList = [
    UserGroup(
      groupName: 'Select Tag Group',
      id: '',
      isactive: 1,
    )
  ].obs;
  RxString selectedUserGroupList = ''.obs;
  Rx<TextEditingController> tagNameController = TextEditingController().obs;
}
