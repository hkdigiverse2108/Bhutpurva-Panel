import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:universal_html/html.dart' as html;

import '../../../app/app_pages.dart';

class DashboardController extends GetxController {
  static DashboardController get instance => Get.find();

  StreamSubscription? _popStateSubscription;

  @override
  void onInit() {
    super.onInit();
    if (kIsWeb) {
      _popStateSubscription = html.window.onPopState.listen((event) {
        if (Get.currentRoute != AppPages.dashboard) {
          Get.back();
        }
      });
    }
  }

  @override
  void onClose() {
    _popStateSubscription?.cancel();
    super.onClose();
  }
}
