import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../shared/app_colors.dart';
import '../shared/app_styles.dart';

class RichTextWidget extends StatelessWidget {
  final String firstTxt;
  final String secondTxt;
  final VoidCallback onTap;
  final bool isLight;

  const RichTextWidget(
      {Key? key,
      required this.firstTxt,
      required this.secondTxt,
      required this.onTap,
      this.isLight = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
          text: firstTxt.tr,
          style: AppStyles.kBodyStyle.copyWith(color: AppColors.kcTextPrimary),
          children: <TextSpan>[
            TextSpan(
                text: ' ${secondTxt.tr}',
                style: AppStyles.kBodyStyle.copyWith(
                    color: isLight
                        ? AppColors.kAltBgDark
                        : AppColors.kcPrimaryColor),
                recognizer: TapGestureRecognizer()..onTap = onTap)
          ]),
    );
  }
}
