import 'package:get/get.dart';

class CalenderController extends GetxController {
  static CalenderController get instance => Get.find();

  List months = [
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

  var selected = ''.obs;

  var year = DateTime.now().year;

  @override
  void onInit() {
    selected.value = months.first;
    super.onInit();
  }
}
