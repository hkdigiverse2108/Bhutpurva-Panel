import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class HelperFunctions {
  static DateTime getStartOfWeek(DateTime date) {
    final int daysUntilMonday = DateTime.now().weekday - 1;
    final DateTime startOfWeek = DateTime.now().subtract(
      Duration(days: daysUntilMonday),
    );
    return DateTime(
      startOfWeek.year,
      startOfWeek.month,
      startOfWeek.day,
      0,
      0,
      0,
      0,
      0,
    );
  }

  static void navigateToScreen(BuildContext context, Widget screen) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
  }

  static String truncateText(String text, int maxLength) {
    if (text.length <= maxLength) {
      return text;
    } else {
      return '${text.substring(0, maxLength)}...';
    }
  }

  static bool isDarkMode(BuildContext context) {
    return false;
    // return MediaQuery.of(context).platformBrightness == Brightness.dark;
  }

  static Size screenSize() {
    return MediaQuery.of(Get.context!).size;
  }

  static double screenWidth() {
    return MediaQuery.of(Get.context!).size.width;
  }

  static double screenHeight() {
    return MediaQuery.of(Get.context!).size.height;
  }

  static bool isHeightValid(double height) {
    final double screenHeight = MediaQuery.of(Get.context!).size.height;
    return height >= screenHeight;
  }

  static bool isWidthValid(double width) {
    final double screenWidth = MediaQuery.of(Get.context!).size.width;
    return width >= screenWidth;
  }

  static String getFormattedDate(
    DateTime date, {
    String format = 'dd MMM yyyy',
  }) {
    return DateFormat(format).format(date);
  }
}
