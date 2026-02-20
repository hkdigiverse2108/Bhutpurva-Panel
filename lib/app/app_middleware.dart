import 'package:bhutpurva_penal/app/app_pages.dart';
import 'package:bhutpurva_penal/core/services/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {

    final storage = StorageService();

    final isAuthenticated = storage.isLoggedIn;

    return isAuthenticated
        ? null
        : const RouteSettings(name: AppPages.login);
  }
}