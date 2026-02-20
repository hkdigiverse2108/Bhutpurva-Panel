import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:url_strategy/url_strategy.dart';

import 'app/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Remove # sign from url
  setPathUrlStrategy();

  // Initialize GetStorage
  await GetStorage.init();

  runApp(const App());
}