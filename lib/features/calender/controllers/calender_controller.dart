import 'package:bhutpurva_penal/core/constants/api_constants.dart';
import 'package:bhutpurva_penal/core/services/api_service.dart';
import 'package:bhutpurva_penal/features/calender/models/tithi_calendar_model.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:mime/mime.dart';
import 'package:http_parser/http_parser.dart';

class CalenderController extends GetxController {
  static CalenderController get instance => Get.find();

  var tithiCalender = Rx<TithiCalenderModel?>(null);

  var isLoading = false.obs;
  var isUploading = false.obs;

  final apiService = ApiService();
  final ImagePicker _picker = ImagePicker();

  var year = DateTime.now().year.obs;

  final List<String> uiMonths = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];

  final Map<String, String> backendMonths = {
    'Jan': 'january',
    'Feb': 'february',
    'Mar': 'march',
    'Apr': 'april',
    'May': 'may',
    'Jun': 'june',
    'Jul': 'july',
    'Aug': 'august',
    'Sep': 'september',
    'Oct': 'october',
    'Nov': 'november',
    'Dec': 'december',
  };

  @override
  void onInit() {
    super.onInit();
    fetchCalendar();
  }

  Future<void> fetchCalendar() async {
    try {
      isLoading(true);
      final res = await apiService.get(
        ApiConstants.tithiCalendar(year: year.value),
      );

      if (res.status == 200 &&
          res.data != null &&
          res.data is Map<String, dynamic> &&
          res.data['tithiCalender'] != null) {
        tithiCalender.value = TithiCalenderModel.fromJson(
          res.data['tithiCalender'] as Map<String, dynamic>,
        );
      } else {
        await initializeCalendar();
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading(false);
    }
  }

  Future<void> initializeCalendar() async {
    try {
      final res = await apiService.post(
        ApiConstants.initTithiCalendar,
        body: {"year": year.value, "calender": []},
      );
      if (res.status == 200 &&
          res.data != null &&
          res.data is Map<String, dynamic> &&
          res.data['tithiCalender'] != null) {
        tithiCalender.value = TithiCalenderModel.fromJson(
          res.data['tithiCalender'] as Map<String, dynamic>,
        );
      }
    } catch (e) {
      Get.snackbar('Error Initializing Calendar', e.toString());
    }
  }

  Future<void> uploadImageForMonth(String uiMonth) async {
    if (tithiCalender.value == null) return;

    try {
      // 1. Pick Image
      final XFile? pickedFile = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
      );

      if (pickedFile == null) return;

      isUploading(true);

      // 2. Prepare file for upload
      final bytes = await pickedFile.readAsBytes();
      final mimeType = lookupMimeType(pickedFile.path) ?? 'image/jpeg';
      final contentType = MediaType.parse(mimeType);

      final multipartFile = http.MultipartFile.fromBytes(
        'files', // Backend expects 'files'
        bytes,
        filename: pickedFile.name,
        contentType: contentType,
      );

      // 3. Get old image to delete from server
      final String? oldImageUrl = getImageForMonth(uiMonth);

      // 4. Upload to /upload
      final uploadRes = await apiService.postMultipart(
        ApiConstants.image,
        files: [multipartFile],
        oldImages: oldImageUrl,
      );

      if (!(uploadRes.status == 200 || uploadRes.status == 201) ||
          uploadRes.data == null) {
        throw Exception(uploadRes.message ?? 'Failed to upload image');
      }

      // 4. Extract URL (Project standard: response.data['files'][0])
      String? imageUrl;
      if (uploadRes.data is Map &&
          uploadRes.data['files'] != null &&
          (uploadRes.data['files'] as List).isNotEmpty) {
        imageUrl = uploadRes.data['files'][0];
      }

      if (imageUrl == null || imageUrl.isEmpty) {
        throw Exception('Uploaded image URL not found in response');
      }

      // 5. Update Calendar Month in DB
      String backendMonth = backendMonths[uiMonth]!;
      final updateRes = await apiService.post(
        ApiConstants.updateTithiCalendarMonth,
        body: {
          "tithiCalenderId": tithiCalender.value!.id,
          "month": backendMonth,
          "image": imageUrl,
        },
      );

      if (updateRes.status == 200) {
        Get.snackbar('Success', 'Image updated successfully');
        await fetchCalendar();
      } else {
        Get.snackbar('Error', updateRes.message ?? 'Failed to update calendar');
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isUploading(false);
    }
  }

  String? getImageForMonth(String uiMonth) {
    if (tithiCalender.value == null) return null;
    String backendMonth = backendMonths[uiMonth]!;

    try {
      var monthData = tithiCalender.value!.calender.firstWhere(
        (element) => element.month == backendMonth,
      );
      if (monthData.image.isNotEmpty) {
        return monthData.image;
      }
    } catch (e) {
      return null;
    }
    return null;
  }
}
