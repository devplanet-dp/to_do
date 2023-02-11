import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do/core/routes/app_routes.dart';
import 'package:to_do/feature/signin/signin_binding.dart';

class SignInPage extends GetView<SignInBinding> {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SignInScreen(
      actions: [
        //on user sign up
        AuthStateChangeAction<UserCreated>((context, state) {
          Get.toNamed(AppRoutes.name);
        }),
        //on user sign up
        AuthStateChangeAction<SignedIn>((context, state) {
          Get.toNamed(AppRoutes.home);
        })
      ],
      providers: [EmailAuthProvider()],
    );
  }
}
