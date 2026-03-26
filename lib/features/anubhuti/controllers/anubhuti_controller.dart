import 'dart:io';
import 'package:bhutpurva_penal/core/constants/enums.dart';
import 'package:bhutpurva_penal/features/settings/controllers/settings_controller.dart';
import 'package:bhutpurva_penal/shared/widgets/snackbar/app_snackbar.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

import 'package:bhutpurva_penal/core/helpers/base_controller.dart';
import 'package:bhutpurva_penal/core/constants/api_constants.dart';
import 'package:bhutpurva_penal/core/services/api_service.dart';
import 'package:bhutpurva_penal/shared/models/anubhuti_models/anubhuti_model.dart';
import 'package:bhutpurva_penal/shared/models/res/res_model.dart';
import 'package:bhutpurva_penal/shared/widgets/Upload_image/upload_image.dart';
import 'package:mime/mime.dart';

class AnubhutiController extends BaseController {
  static AnubhutiController get instance => Get.find();

  final settingsController = SettingsController.instance;

  final apiService = ApiService();

  var anubhuti = <AnubhutiModel>[].obs;

  int page = 1;
  int rowsPerPage = 10;
  int total = 0;

  final searchController = TextEditingController();
  var query = ''.obs;
  late Worker _searchWorker;

  var isUploading = false.obs;

  final Rx<File?> selectedImage = Rx<File?>(null);
  final Rx<Uint8List?> webImage = Rx<Uint8List?>(null);

  final ImagePicker _picker = ImagePicker();
  var currentImageUrl = RxnString();

  @override
  void onInit() {
    super.onInit();

    currentImageUrl.value = settingsController.anubhutiImage.value;

    // Listen for changes in settings and update currentImageUrl
    ever(settingsController.anubhutiImage, (String val) {
      currentImageUrl.value = val;
    });

    _searchWorker = debounce(query, (_) {
      page = 1;
      fetchAnubhuti();
    }, time: const Duration(milliseconds: 400));

    fetchAnubhuti();
  }

  void fetchAnubhuti() {
    executeApi(
      apiCall: () async {
        final ResModel res = await apiService.get(
          ApiConstants.anubhuti(
            page: page,
            limit: rowsPerPage,
            query: query.value,
          ),
        );

        if (res.status == 200) {
          final dataList = res.data['anubhutis'] ?? res.data['data'] ?? [];

          anubhuti.assignAll(
            (dataList as Iterable)
                .map<AnubhutiModel>((e) => AnubhutiModel.fromJson(e))
                .toList(),
          );

          total = res.data['totalData'] ?? 0;
        }
      },
      errorMessage: "Failed to fetch anubhuti",
    );
  }

  void onDeleteAnubhuti(String id) {
    executeApi(
      apiCall: () async {
        final ResModel res = await apiService.delete(
          ApiConstants.deleteAnubhuti(id),
        );

        if (res.status == 200) {
          anubhuti.removeWhere((element) => element.id == id);
          total--;
        }
      },
      errorMessage: "Failed to delete anubhuti",
    );
  }

  void onSearchChanged(String value) {
    query.value = value;
  }

  void onPageChange(int value) {
    page = (value ~/ rowsPerPage) + 1;
    fetchAnubhuti();
  }

  Future<void> pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile == null) return;

    if (kIsWeb) {
      final bytes = await pickedFile.readAsBytes();
      webImage.value = bytes;
    } else {
      selectedImage.value = File(pickedFile.path);
    }
  }

  void handleImageSelection(dynamic file) {
    if (kIsWeb) {
      webImage.value = file;
    } else {
      selectedImage.value = file;
    }
  }

  Future<void> uploadImage(XFile pickedFile) async {
    try {
      isUploading(true);

      final bytes = await pickedFile.readAsBytes();
      final mimeType = lookupMimeType(pickedFile.path) ?? 'image/jpeg';

      final multipartFile = http.MultipartFile.fromBytes(
        'files',
        bytes,
        filename: pickedFile.name,
        contentType: MediaType.parse(mimeType),
      );

      final uploadRes = await apiService.postMultipart(
        ApiConstants.image,
        files: [multipartFile],
        oldImages: currentImageUrl.value,
      );

      if (!(uploadRes.status == 200 || uploadRes.status == 201)) {
        throw Exception(uploadRes.message ?? 'Upload failed');
      }

      // ✅ update new image
      if (uploadRes.data is Map &&
          uploadRes.data['files'] != null &&
          (uploadRes.data['files'] as List).isNotEmpty) {
        currentImageUrl.value = uploadRes.data['files'][0];
      }

      final ResModel res = await apiService.post(
        ApiConstants.updateSettings,
        body: {"anubhutiImage": currentImageUrl.value},
      );

      if (res.status == 200) {
        settingsController.anubhutiImage.value = currentImageUrl.value ?? '';
        Get.back();
        AppSnackBar.show(
          title: "Success",
          message: "Image updated successfully",
          type: AppSnackBarType.success,
        );
      } else {
        AppSnackBar.show(
          title: "Error",
          message: res.message ?? 'Failed to update image',
          type: AppSnackBarType.error,
        );
      }
    } catch (e) {
      AppSnackBar.show(
        title: "Error",
        message: e.toString(),
        type: AppSnackBarType.error,
      );
    } finally {
      isUploading(false);
    }
  }

  void openUploadImagePopup() {
    Get.dialog(
      Obx(
        () => UploadImage(
          imageUrl: currentImageUrl.value,
          isUploading: isUploading.value,
          onUpload: (file) {
            uploadImage(file);
          },
        ),
      ),
    );
  }

  @override
  void onClose() {
    searchController.dispose();
    _searchWorker.dispose();
    super.onClose();
  }
}
