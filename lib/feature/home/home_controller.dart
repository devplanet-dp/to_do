import 'package:get/get.dart';
import 'package:to_do/data/controllers/auth_controller.dart';

import '../../core/base/base_controller.dart';
import '../../core/routes/app_routes.dart';

class HomeController extends BaseController {
  final _authService = Get.find<AuthenticationController>();

  @override
  void onInit() {
    super.onInit();
  }


}
