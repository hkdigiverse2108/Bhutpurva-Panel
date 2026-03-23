import 'dart:developer';
import 'package:bhutpurva_penal/core/constants/api_constants.dart';
import 'package:bhutpurva_penal/core/constants/enums.dart';
import 'package:bhutpurva_penal/core/helpers/base_controller.dart';
import 'package:bhutpurva_penal/core/services/api_service.dart';
import 'package:bhutpurva_penal/core/services/storage_service.dart';
import 'package:bhutpurva_penal/shared/models/res/res_model.dart';
import 'package:bhutpurva_penal/shared/models/setting_model/setting_model.dart';
import 'package:bhutpurva_penal/shared/models/user/user_model.dart';
import 'package:bhutpurva_penal/shared/widgets/snackbar/app_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quill_html_editor/quill_html_editor.dart';

class SettingsController extends BaseController {
  static SettingsController get instance => Get.find();

  final apiService = ApiService();

  var isSettingsLoading = false.obs;
  var isUserLoading = false.obs;
  var isSettingsUpdateLoading = false.obs;

  final Map<String, bool> _policyLoaded = {};
  final Map<String, String> _policyContent = {};
  final Map<String, bool> _policyFetching = {};

  Rxn<SettingModel> settingData = Rxn<SettingModel>();
  RxString settingId = ''.obs;

  final legalityData = Rxn<LegalityModel>();
  final legalityId = ''.obs;

  final usersData = <UserModel>[].obs;
  final usersId = ''.obs;
  final usersName = ''.obs;
  final usersEmail = ''.obs;
  final usersPhone = ''.obs;
  final usersCurrentCity = ''.obs;
  final usersProfileImage = ''.obs;

  // Profile fields (linked to UserModel)
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final addressController = TextEditingController();
  final cityController = TextEditingController();

  // App details fields (linked to Setting model)
  final appNameController = TextEditingController();
  final webSiteUrlController = TextEditingController();
  final appUrlController = TextEditingController();
  final playStoreUrlController = TextEditingController();
  final appStoreUrlController = TextEditingController();
  final playStoreIdController = TextEditingController();
  final appStoreIdController = TextEditingController();
  final sgsiPdfController = TextEditingController();
  final appLogo = ''.obs;
  final organizationAddressController = TextEditingController();

  // Support details fields (linked to Setting model)
  final supportPhoneController = TextEditingController();
  final supportWhatsAppController = TextEditingController();
  final supportEmailController = TextEditingController();

  // Social Links
  final facebookController = TextEditingController();
  final instagramController = TextEditingController();
  final twitterController = TextEditingController();
  final linkedinController = TextEditingController();
  final youtubeController = TextEditingController();

  // Policy fields (linked to Setting model)
  final policyEditorController = QuillEditorController();

  // Password fields
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

  final otherController = TextEditingController();
  final notificationController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    fetchSettings();
    fetchUserDetails();
    
    // Reactively load policy whenever the selection changes
    ever(selectedPolicy, (PolicyType type) {
      log("Selected policy changed to: ${type.name}");
      fetchPolicy(getPolicyTypeString(type));
    });
  }

  String getPolicyTypeString(PolicyType type) {
    switch (type) {
      case PolicyType.privacy: return 'privacy_policy';
      case PolicyType.activist: return 'activist_policy';
      case PolicyType.aboutApp: return 'about_app';
    }
  }

  @override
  void onReady() {
    super.onReady();
    if (selectedTab.value == 'policy') {
      fetchPolicy(getPolicyTypeString(selectedPolicy.value));
    }
  }

  void fetchSettings() {
    executeApi(
      loadingState: isSettingsLoading,
      apiCall: () async {
        final res = await apiService.get(ApiConstants.settings);
        log("Settings API Response: ${res.data}");

        if (res.status == 200) {
          final data = res.data;

          SettingModel model;

          if (data is Map<String, dynamic> && data.containsKey('setting')) {
            model = SettingModel.fromJson(data);
          } else if (data is Iterable && data.isNotEmpty) {
            model = SettingModel(setting: Setting.fromJson(data.first));
          } else if (data is Map<String, dynamic>) {
            model = SettingModel(setting: Setting.fromJson(data));
          } else {
            return;
          }

          settingData.value = model;
          settingId.value = model.setting?.id ?? '';

          _populateSettingsControllers(model);
        }
      },
    );
  }

  void fetchUserDetails() {
    final currentUserId = StorageService.instance.user?.id;
    log("Fetching user details for ID: $currentUserId");
    if (currentUserId == null) return;

    executeApi(
      loadingState: isUserLoading,
      apiCall: () async {
        final res = await apiService.get(
          ApiConstants.userDetails(currentUserId),
        );
        log("User Details API Response: ${res.data}");
        if (res.status == 200) {
          final model = UserModel.fromJson(res.data);
          usersId.value = model.id;
          usersName.value = model.name;
          usersEmail.value = model.email;
          usersPhone.value = model.phoneNumber;
          usersCurrentCity.value = model.currentCity;
          usersProfileImage.value = model.image ?? '';

          _populateUserControllers(model);
        }
      },
    );
  }

  String getPolicyContent(String type) => _policyContent[type] ?? "";

  Future<void> fetchPolicy(String type, {bool force = false}) async {
    // If we already have the content and not forcing, just re-apply it to the editor
    if (_policyLoaded[type] == true && !force) {
      log("Policy $type already loaded, re-applying stored content.");
      _applyPolicyContent(type);
      return;
    }

    // Prevent duplicate active fetches
    if (_policyFetching[type] == true) {
      log("Already fetching $type, skipping duplicate call.");
      return;
    }

    _policyFetching[type] = true;

    await executeApi(
      loadingState: isSettingsLoading,
      apiCall: () async {
        final ResModel res = await apiService.get(ApiConstants.legality(type));

        if (res.status == 200) {
          final data = res.data;
          LegalityModel model;

          if (data is Map<String, dynamic> && data.containsKey('legality')) {
            model = LegalityModel.fromJson(data['legality']);
          } else if (data is Map<String, dynamic> && data.containsKey('data')) {
            // handle extra nesting if present
            model = LegalityModel.fromJson(data['data']);
          } else if (data is Iterable && data.isNotEmpty) {
            model = LegalityModel.fromJson(data.first);
          } else if (data is Map<String, dynamic>) {
            model = LegalityModel.fromJson(data);
          } else {
            log(
              "Error: Data is not in expected format for fetchPolicy ($type)",
            );
            return;
          }

          log(
            "Setting content for $type: ${model.content?.substring(0, model.content!.length > 20 ? 20 : model.content!.length)}...",
          );

          _policyContent[type] = model.content ?? "";
          _policyLoaded[type] = true;

          await _applyPolicyContent(type);
          log("Content fetched and set successfully for $type");
        }
      },
    );
    _policyFetching[type] = false;
  }

  Future<void> _applyPolicyContent(String type) async {
    final content = _policyContent[type] ?? "";
    if (content.isEmpty) return;

    // Ensure we only apply if the current selected policy matches the type being applied
    if (getPolicyTypeString(selectedPolicy.value) != type) {
      log("Skipping setText for $type because it's no longer selected.");
      return;
    }

    // Small delay to ensure the editor's bridge is ready
    await Future.delayed(const Duration(milliseconds: 500));

    try {
      await setText(content);
      log("Applied content to editor for $type");
    } catch (e) {
      log("Error applying content to editor for $type: $e");
    }
  }

  Future<void> _applyCurrentPolicy() async {
    await fetchPolicy(getPolicyTypeString(selectedPolicy.value));
  }

  Future<void> setText(String content) async {
    await policyEditorController.setText(content);
  }

  void _populateSettingsControllers(SettingModel model) {
    final setting = model.setting;
    appNameController.text = setting?.appName ?? '';
    webSiteUrlController.text = setting?.webSiteUrl ?? '';
    appUrlController.text = setting?.appUrl ?? '';
    playStoreUrlController.text = setting?.playStoreUrl ?? '';
    appStoreUrlController.text = setting?.appStoreUrl ?? '';
    playStoreIdController.text = setting?.playStoreId ?? '';
    appStoreIdController.text = setting?.appStoreId ?? '';
    sgsiPdfController.text = setting?.sgsiPdf ?? '';
    appLogo.value = setting?.logo ?? '';
    organizationAddressController.text = setting?.address ?? '';

    // Support controls
    supportPhoneController.text = setting?.supportPhone ?? '';
    supportWhatsAppController.text = setting?.supportWhatsApp ?? '';
    supportEmailController.text = setting?.supportEmail ?? '';

    // Social links
    final socials = setting?.socialLinks;
    facebookController.text = socials?.facebook ?? '';
    instagramController.text = socials?.instagram ?? '';
    twitterController.text = socials?.twitter ?? '';
    linkedinController.text = socials?.linkedin ?? '';
    youtubeController.text = socials?.youtube ?? '';
  }

  void _populateUserControllers(UserModel model) {
    nameController.text = model.name;
    phoneController.text = model.phoneNumber;
    emailController.text = model.email;
    cityController.text = model.currentCity;
  }

  void updateSettings() {
    executeApi(
      loadingState: isSettingsUpdateLoading,
      apiCall: () async {
        final body = {
          'id': settingId.value,
          'appName': appNameController.text,
          'webSiteUrl': webSiteUrlController.text,
          'appUrl': appUrlController.text,
          'playStoreUrl': playStoreUrlController.text,
          'appStoreUrl': appStoreUrlController.text,
          'playStoreId': playStoreIdController.text,
          'appStoreId': appStoreIdController.text,
          'sgsiPdf': sgsiPdfController.text,
          'address': organizationAddressController.text,
          'supportPhone': supportPhoneController.text,
          'supportWhatsApp': supportWhatsAppController.text,
          'supportEmail': supportEmailController.text,
          'socialLinks': {
            'facebook': facebookController.text,
            'instagram': instagramController.text,
            'twitter': twitterController.text,
            'linkedin': linkedinController.text,
            'youtube': youtubeController.text,
          },
        };
        log("Updating Settings with body: $body");

        final res = await apiService.post(
          ApiConstants.updateSettings,
          body: body,
        );
        log("Update Settings Response: ${res.data}");
        if (res.status == 200) {
          fetchSettings();
        }
      },
    );
  }

  void updatePassword() {
    executeApi(
      loadingState: isSettingsUpdateLoading,
      apiCall: () async {
        final body = {
          'currentPassword': currentPasswordController.text,
          'newPassword': newPasswordController.text,
          'confirmPassword': confirmPasswordController.text,
        };
        log("Updating Password with body: $body");

        final res = await apiService.post(
          ApiConstants.updateSettings,
          body: body,
        );
        log("Update Password Response: ${res.data}");
        if (res.status == 200) {
          fetchSettings();
        }
      },
    );
  }

  void updateNotification() {
    executeApi(
      loadingState: isSettingsUpdateLoading,
      apiCall: () async {
        final body = {'notification': notificationController.text};
        log("Updating Notification with body: $body");

        final res = await apiService.post(
          ApiConstants.updateSettings,
          body: body,
        );
        log("Update Notification Response: ${res.data}");
        if (res.status == 200) {
          fetchSettings();
        }
      },
    );
  }

  void updateOther() {
    executeApi(
      loadingState: isSettingsUpdateLoading,
      apiCall: () async {
        final body = {
          'id': settingId.value,
          'supportPhone': supportPhoneController.text,
          'supportWhatsApp': supportWhatsAppController.text,
          'supportEmail': supportEmailController.text,
          'socialLinks': {
            'facebook': facebookController.text,
            'instagram': instagramController.text,
            'twitter': twitterController.text,
            'linkedin': linkedinController.text,
            'youtube': youtubeController.text,
          },
        };
        log("Updating Support & Social with body: $body");

        final res = await apiService.post(
          ApiConstants.updateSettings,
          body: body,
        );
        log("Update Support Settings Response: ${res.data}");
        if (res.status == 200) {
          fetchSettings();
        }
      },
    );
  }

  void updateApp() {
    executeApi(
      loadingState: isSettingsUpdateLoading,
      apiCall: () async {
        final body = {
          'appName': appNameController.text,
          'webSiteUrl': webSiteUrlController.text,
          'playStoreUrl': playStoreUrlController.text,
          'appStoreUrl': appStoreUrlController.text,
          'playStoreId': playStoreIdController.text,
          'appStoreId': appStoreIdController.text,
          'sgsiPdf': sgsiPdfController.text,
          'address': organizationAddressController.text,
        };
        log("Updating App Settings with body: $body");

        final res = await apiService.post(
          ApiConstants.updateSettings,
          body: body,
        );
        log("Update App Settings Response: ${res.data}");
        if (res.status == 200) {
          fetchSettings();
        }
      },
    );
  }

  void updatePolicy(String type) {
    executeApi(
      loadingState: isSettingsUpdateLoading,
      apiCall: () async {
        final html = await policyEditorController.getText();

        final body = {
          'type': type,
          'content': html,
        };
        log("Updating Policy $type with body: $body");

        final res = await apiService.post(
          ApiConstants.updateLegality,
          body: body,
        );
        log("Update Policy Response: ${res.data}");
        if (res.status == 200) {
          fetchPolicy(type, force: true);
        }
      },
    );
  }

  void updateAccount() {
    final userId = usersId.value;
    log("Updating Account for User ID: $userId");

    executeApi(
      loadingState: isSettingsUpdateLoading,
      apiCall: () async {
        final body = {
          "userId": userId,
          "name": nameController.text,
          "phoneNumber": phoneController.text,
          "email": emailController.text,
          "currentCity": cityController.text,
        };
        log("Updating Account with body: $body");

        final res = await apiService.put(ApiConstants.updateUser, body: body);
        log("Update Account Response: ${res.data}");

        if (res.status == 200) {
          fetchUserDetails();
          AppSnackBar.show(
            type: AppSnackBarType.success,
            title: "Success",
            message: "Profile updated",
          );
        }
      },
    );
  }

  void changeTab(String tab) {
    selectedTab.value = tab;
    if (tab == 'policy') {
      _applyCurrentPolicy();
    }
  }

  void select(PolicyType type) {
    selectedPolicy.value = type;
  }

  @override
  void onClose() {
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    appNameController.dispose();
    webSiteUrlController.dispose();
    cityController.dispose();
    appUrlController.dispose();
    playStoreUrlController.dispose();
    appStoreUrlController.dispose();
    playStoreIdController.dispose();
    appStoreIdController.dispose();
    sgsiPdfController.dispose();
    policyEditorController.dispose();
    organizationAddressController.dispose();
    supportPhoneController.dispose();
    supportWhatsAppController.dispose();
    supportEmailController.dispose();
    facebookController.dispose();
    instagramController.dispose();
    twitterController.dispose();
    linkedinController.dispose();
    youtubeController.dispose();
    currentPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    otherController.dispose();
    notificationController.dispose();
    super.onClose();
  }
}
