import 'package:bhutpurva_penal/core/constants/enums.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quill_html_editor/quill_html_editor.dart';

class SettingsController extends GetxController {
  static SettingsController get instance => Get.find();

  final nameController = TextEditingController();

  final appNameController = TextEditingController();
  final webSiteUrlController = TextEditingController();
  final appUrlController = TextEditingController();
  final playStoreUrlController = TextEditingController();
  final appStoreUrlController = TextEditingController();
  final aboutAppController = TextEditingController();

  final privacyPolicyController = QuillEditorController();
  final activistPolicyController = QuillEditorController();

  final currentPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  var currentPasswordHidden = true.obs;
  var newPasswordHidden = true.obs;
  var confirmPasswordHidden = true.obs;

  final selectedPolicy = PolicyType.privacy.obs;

  var selectedTab = 'Account'.obs;

  var tabs = [
    'Account',
    'Security',
    'Notification',
    'App',
    'policy',
    'other',
  ].obs;

  final accountFormKey = GlobalKey<FormState>();
  final appFormKey = GlobalKey<FormState>();
  final securityFormKey = GlobalKey<FormState>();
  final otherFormKey = GlobalKey<FormState>();

  void changeTab(String tab) {
    selectedTab.value = tab;
  }

  void select(PolicyType type) {
    selectedPolicy.value = type;
  }
}
