import 'package:bhutpurva_penal/app/app_pages.dart';
import 'package:bhutpurva_penal/core/device/device_utility.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SidebarController extends GetxController {
  static SidebarController get instance => Get.find();

  final activeItem = AppPages.dashboard.obs;
  final hoverItem = ''.obs;
  final position = 0.0.obs;

  /// NEW: store expanded states for each menu
  final expandedItems = <String, bool>{}.obs;

  @override
  void onInit() {
    scroll.addListener(() {
      position.value = scroll.position.pixels;
    });
    super.onInit();
  }

  void restore() {
    Future.delayed(Duration(milliseconds: 50), () {
      scroll.jumpTo(position.value);
    });
  }

  void changeActiveItem(String route) => activeItem.value = route;
  final scroll = ScrollController();

  void changeHoverItem(String route) {
    if (!isActive(route)) hoverItem.value = route;
  }

  void toggleExpand(String route) {
    expandedItems[route] = !(expandedItems[route] ?? false);
  }

  bool isActive(String route) => activeItem.value == route;

  bool isExpanded(String route) => expandedItems[route] ?? false;

  bool isHovering(String route) => hoverItem.value == route;

  void menuOnTap(String route, {bool isSubItem = false, String? parentRoute}) {
    if (!isActive(route)) {
      changeActiveItem(route);

      // If this is a sub-item and has a parent route, expand the parent
      if (isSubItem && parentRoute != null) {
        expandedItems[parentRoute] = true;
      }

      if (DeviceUtility.isMobileScreen(Get.context!)) Get.back();

      Get.toNamed(route);
    }
  }
}
