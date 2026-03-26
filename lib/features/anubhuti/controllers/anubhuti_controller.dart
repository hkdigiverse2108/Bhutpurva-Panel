import 'dart:io';
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

      Get.snackbar('Success', 'Image uploaded');

      Get.back();
      fetchAnubhuti();
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isUploading(false);
    }
  }

  void openUploadImagePopup() {
    Get.dialog(
      UploadImage(
        imageUrl: currentImageUrl.value,
        onUpload: (file) {
          uploadImage(file);
        },
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
