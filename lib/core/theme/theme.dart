import 'package:bhutpurva_penal/core/constants/color_const.dart';
import 'package:bhutpurva_penal/core/constants/size_const.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static final ThemeData adminLightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: ColorConst.primary,

    colorScheme: ColorScheme.light(
      primary: ColorConst.primary,
      secondary: ColorConst.secondary,
      error: ColorConst.error,
      surface: ColorConst.white,
    ),

    scaffoldBackgroundColor: ColorConst.primaryBackground,

    // ----------------------------------------------------------------
    // APP BAR – calmer, lighter, enterprise
    // ----------------------------------------------------------------
    appBarTheme: AppBarTheme(
      backgroundColor: ColorConst.white,
      elevation: 0,
      scrolledUnderElevation: 0,
      iconTheme: IconThemeData(color: ColorConst.iconPrimary, size: 22),
      titleTextStyle: GoogleFonts.poppins(
        color: ColorConst.textPrimary,
        fontWeight: FontWeight.w500, // 🔽 lighter
        fontSize: 18, // 🔽 smaller
      ),
    ),

    iconTheme: IconThemeData(color: ColorConst.iconPrimary, size: 20),

    // ----------------------------------------------------------------
    // TEXT THEME – less bold, more enterprise
    // ----------------------------------------------------------------
    textTheme: TextTheme(
      titleLarge: GoogleFonts.poppins(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: ColorConst.textPrimary,
      ),
      titleMedium: GoogleFonts.poppins(
        fontSize: 15,
        fontWeight: FontWeight.w500,
        color: ColorConst.textPrimary,
      ),
      titleSmall: GoogleFonts.poppins(
        fontSize: 13,
        fontWeight: FontWeight.w500,
        color: ColorConst.textPrimary,
      ),

      bodyLarge: GoogleFonts.poppins(
        fontSize: 15,
        color: ColorConst.textSecondary,
      ),
      bodyMedium: GoogleFonts.poppins(
        fontSize: 13, // 🔽 smaller body text
        color: ColorConst.textSecondary,
      ),
      bodySmall: GoogleFonts.poppins(
        fontSize: 12,
        color: ColorConst.textSecondary,
      ),

      labelLarge: GoogleFonts.poppins(
        fontSize: 13,
        fontWeight: FontWeight.w500,
        color: ColorConst.textPrimary,
      ),
      labelMedium: GoogleFonts.poppins(
        fontSize: 12,
        color: ColorConst.textSecondary,
      ),
      labelSmall: GoogleFonts.poppins(
        fontSize: 11,
        color: ColorConst.textSecondary,
      ),
    ),

    // ----------------------------------------------------------------
    // BUTTONS – slimmer & calmer
    // ----------------------------------------------------------------
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        elevation: const WidgetStatePropertyAll(0),
        // 🔽 flatter
        backgroundColor: WidgetStatePropertyAll(ColorConst.buttonPrimary),
        foregroundColor: WidgetStatePropertyAll(ColorConst.textWhite),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(SizeConst.buttonRadius - 2),
          ),
        ),
        textStyle: WidgetStatePropertyAll(
          GoogleFonts.poppins(
            fontSize: 13, // 🔽 smaller
            fontWeight: FontWeight.w500,
          ),
        ),
        minimumSize: WidgetStatePropertyAll(
          Size.fromHeight(SizeConst.buttonHeight - 6), // 🔽 shorter
        ),
      ),
    ),

    // ----------------------------------------------------------------
    // INPUT FIELDS – ENTERPRISE REFINEMENT (IMPORTANT)
    // ----------------------------------------------------------------
    inputDecorationTheme: InputDecorationTheme(
      isDense: true,
      // ✅ makes field smaller
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 10, // 🔽 reduced height
      ),

      filled: true,
      fillColor: ColorConst.white,

      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(SizeConst.inputFieldRadius - 2),
        borderSide: BorderSide(
          color: ColorConst.borderPrimary.withOpacity(0.6),
        ),
      ),

      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(SizeConst.inputFieldRadius - 2),
        borderSide: BorderSide(
          color: ColorConst.borderPrimary.withOpacity(0.6),
        ),
      ),

      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(SizeConst.inputFieldRadius - 2),
        borderSide: BorderSide(color: ColorConst.primary, width: 1.2),
      ),

      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(SizeConst.inputFieldRadius - 2),
        borderSide: BorderSide(color: ColorConst.error),
      ),

      hintStyle: GoogleFonts.poppins(fontSize: 12, color: ColorConst.grey),

      labelStyle: GoogleFonts.poppins(fontSize: 12, color: ColorConst.darkGrey),
    ),

    // ----------------------------------------------------------------
    // DIVIDERS / CARDS – subtle
    // ----------------------------------------------------------------
    cardColor: ColorConst.white,
    dividerColor: ColorConst.grey.withOpacity(0.4),

    snackBarTheme: SnackBarThemeData(
      backgroundColor: ColorConst.darkerGrey,
      contentTextStyle: TextStyle(color: ColorConst.textWhite),
    ),

    checkboxTheme: CheckboxThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(SizeConst.borderRadiusSm),
      ),
    ),
  );
}
