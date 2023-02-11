import 'package:get/get.dart';
import 'package:to_do/data/controllers/auth_controller.dart';

import '../../core/base/base_controller.dart';
import '../../core/routes/app_routes.dart';

class StartUpController extends BaseController {
  final _authService = Get.find<AuthenticationController>();



  void handleStartUpLogic() async {
    var currentUser = await _authService.isUserLoggedIn();
    if (currentUser.data == null) {
      Get.offNamed(AppRoutes.signIn);
    } else {
      Get.offNamed(AppRoutes.signIn);
    }
  }
}
