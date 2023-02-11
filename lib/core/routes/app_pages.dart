import 'package:get/get.dart';
import 'package:to_do/feature/signin/signin_binding.dart';
import 'package:to_do/feature/signin/signin_page.dart';

import '../../feature/startup/startup_binding.dart';
import '../../feature/startup/startup_page.dart';
import 'app_routes.dart';

class AppPages {
  // add a private constructor to prevent this class being instantiated

  AppPages._();

  static final List<GetPage> pages = [
    GetPage(
      name: AppRoutes.startup,
      page: () => const StartUpPage(),
      binding: StartUpBinding(),
    ),
    GetPage(
      name: AppRoutes.signIn,
      page: () => const SignInPage(),
      binding: SignInBinding(),
    ),
  ];
}