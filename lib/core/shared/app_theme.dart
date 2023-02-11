import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';
import 'app_styles.dart';

class AppTheme{
  static final AppTheme _singleton = AppTheme._internal();
  factory AppTheme() => _singleton;
  AppTheme._internal();

  final ThemeData themeData = ThemeData(
    textTheme: GoogleFonts.poppinsTextTheme(),
    brightness: Brightness.light,
    backgroundColor: Colors.white,
    dividerColor: Colors.transparent,
    dialogTheme: const DialogTheme(
    ),
    chipTheme: const ChipThemeData(
      selectedColor: AppColors.kcPrimaryColor,
      backgroundColor: AppColors.kAltWhite,
    ),

    appBarTheme: AppBarTheme(
        color: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color:AppColors.kcTextPrimary),
        titleTextStyle: AppStyles.kSubheadingStyle.copyWith(fontWeight: FontWeight.w500)),
    scaffoldBackgroundColor: Colors.white,
    primaryColor: AppColors.kcPrimaryColor,
  );

  final ThemeData themeDataDark = ThemeData(
    textTheme: GoogleFonts.robotoSlabTextTheme(),
    brightness: Brightness.dark,
    backgroundColor:AppColors.kAltBg,
    scaffoldBackgroundColor: AppColors.kBlack,
    primaryColor: AppColors.kcPrimaryColor,
  );
}


