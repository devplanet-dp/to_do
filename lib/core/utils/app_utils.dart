import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../shared/app_colors.dart';
import '../widgets/app_dialog.dart';


/// Helper class for common operations.
///
///
class AppUtils {
  AppUtils._();

  static showErrorMessage({required String message, title = 'Info!'}) {
    if (message.isEmpty) return;

    Get.snackbar(title, message,
        backgroundColor: AppColors.kcTextSecondary,
        colorText: AppColors.kAltWhite,
        icon: const Icon(
          Iconsax.warning_2,
          color: AppColors.kAltWhite,
        ));
  }

  static showMessage({String title = 'Info', required String message}) {
    if (message.isEmpty) return;

    Get.dialog(AppDialog(title: title, desc: message));
  }

  static showInfoMessage({required message, title = 'Info!'}) {
    Get.snackbar(title, message,
        backgroundColor: AppColors.kcPrimaryColor,
        colorText: AppColors.kAltWhite,
        padding: const EdgeInsets.symmetric(vertical: 16),
        snackPosition: SnackPosition.BOTTOM,
        icon: const Icon(
          Iconsax.password_check,
          size: 18,
          color: AppColors.kAltWhite,
        ));
  }
}
