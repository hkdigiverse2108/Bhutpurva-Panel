import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:url_strategy/url_strategy.dart';

import 'package:bhutpurva_penal/core/constants/api_constants.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

import 'app/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Configure Logger Level
  Logger.level = ApiConstants.showLogs ? Level.all : Level.off;

  // Configure GetX Logging
  Get.isLogEnable = ApiConstants.showLogs;

  // Remove # sign from url
  setPathUrlStrategy();

  // Initialize GetStorage
  await GetStorage.init();

  runApp(const App());
}