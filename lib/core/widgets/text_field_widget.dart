import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do/core/shared/app_colors.dart';
import 'package:to_do/core/shared/app_styles.dart';


class AppTextField extends StatelessWidget {
  final String? initialValue, prefix, hintText;
  final String label;
  final TextEditingController controller;
  final Color textColor;
  final double margin;
  final Color? fillColor;
  final Color borderColor;
  final int minLine;
  final bool isFilled;
  final Widget? suffix, suffixIcon, prefixWidget, prefixIcon;
  final bool isEmail,
      isPhone,
      isEnabled,
      isPassword,
      isMoney,
      isDark,
      isNumber,
      isTextArea;
  final VoidCallback? onTap;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  final Function()? onEditingComplete;
  final bool isCapitalize;
  final int maxLength;
  final double verticalPadding;
  final TextInputAction textInputAction;
  final double borderRadius;
  final FocusNode? focusNode;

  const AppTextField({
    Key? key,
    this.initialValue,
    this.prefix,
    required this.controller,
    this.onTap,
    required this.hintText,
    this.maxLength = 1000,
    this.isEmail = false,
    this.focusNode,
    this.isEnabled = true,
    this.isTextArea = true,
    this.margin = 0,
    this.isPhone = false,
    this.isPassword = false,
    this.isDark = false,
    this.isMoney = false,
    this.isNumber = false,
    this.isCapitalize = false,
    this.textColor = AppColors.kcTextPrimary,
    this.isFilled = false,
    this.suffix,
    this.prefixWidget,
    this.prefixIcon,
    this.onChanged,
    this.onEditingComplete,
    this.verticalPadding = 12,
    this.validator,
    this.minLine = 1,
    this.fillColor = AppColors.kFillColor,
    this.borderColor = Colors.transparent,
    this.textInputAction = TextInputAction.next,
    this.borderRadius = 6,
    required this.label,
    this.suffixIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        label.isEmpty
            ? const SizedBox.shrink()
            : Text(
                label.tr,
                style: AppStyles.kBodyStyle.copyWith(fontWeight: FontWeight.w700),
              ),
        label.isEmpty ? const SizedBox.shrink() : AppStyles.vSpaceSmall,
        TextFormField(
          focusNode: focusNode,
          textAlign: TextAlign.start,
          initialValue: controller == null ? initialValue : null,
          controller: controller,
          obscureText: isPassword,
          enabled: isEnabled,
          validator: validator,
          onChanged: onChanged,
          minLines: minLine,
          textInputAction: textInputAction,
          onTap: onTap,
          enableInteractiveSelection: isEnabled,
          maxLength: maxLength,
          textCapitalization: isCapitalize
              ? TextCapitalization.sentences
              : TextCapitalization.none,
          onEditingComplete: onEditingComplete,
          maxLines: isTextArea && !isPassword
              ? null
              : isPassword
                  ? 1
                  : 3,
          keyboardType: isEmail
              ? TextInputType.emailAddress
              : isPhone
                  ? TextInputType.phone
                  : isMoney
                      ? const TextInputType.numberWithOptions()
                      : TextInputType.multiline,
          style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 15,
              color: isDark ? Colors.white : textColor),
          decoration: InputDecoration(
            floatingLabelBehavior: FloatingLabelBehavior.never,
            hintText: initialValue,
            labelText: hintText,
            labelStyle: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 15,
                color: isDark
                    ? Colors.white.withOpacity(0.9)
                    : textColor.withOpacity(0.4)),
            counterText: "",
            contentPadding:
                EdgeInsets.symmetric(horizontal: 30, vertical: verticalPadding),
            fillColor: fillColor,
            prefixText: prefix,
            prefix: prefixWidget,
            prefixIcon: prefixIcon,
            prefixIconConstraints:
                const BoxConstraints(minWidth: 0, minHeight: 0),
            suffixIcon: suffixIcon,
            suffix: suffix,
            focusColor: Colors.transparent,
            errorStyle: TextStyle(
                fontWeight: FontWeight.w200,
                fontSize: 11,
                color: isDark ? Colors.white : Colors.red),
            hintStyle: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 15,
                color: isDark ? Colors.white.withOpacity(0.9) : Colors.black),
            filled: isFilled,
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: AppColors.kcStroke),
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: AppColors.kcPrimaryColor),
            ),

          ),
        ),
      ],
    );
  }
}
