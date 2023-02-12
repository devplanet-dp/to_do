import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:to_do/core/routes/app_routes.dart';
import 'package:to_do/core/shared/app_styles.dart';
import 'package:to_do/feature/signin/signin_binding.dart';

class SignInPage extends GetView<SignInBinding> {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SignInScreen(
      headerBuilder: (_, __, ___) => Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.note_alt_outlined,
            size: 32,
          ).paddingSymmetric(horizontal: 16),
          Text(
            'ToDo',
            style:
                AppStyles.kHeading2Style.copyWith(fontWeight: FontWeight.w900),
          ).center(),
        ],
      ),
      actions: [
        //on user sign up
        AuthStateChangeAction<UserCreated>((context, state) {
          Get.toNamed(AppRoutes.name);
        }),
        //on user sign up
        AuthStateChangeAction<SignedIn>((context, state) {
          Get.offAllNamed(AppRoutes.home);
        })
      ],
      providers: [EmailAuthProvider()],
    );
  }
}
