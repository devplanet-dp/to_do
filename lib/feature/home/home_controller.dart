import 'dart:async';

import 'package:get/get.dart';
import 'package:to_do/core/routes/app_routes.dart';
import 'package:to_do/core/utils/app_utils.dart';
import 'package:to_do/data/controllers/auth_controller.dart';
import 'package:to_do/data/controllers/firestore_controller.dart';
import 'package:to_do/data/model/task_model.dart';

import '../../core/base/base_controller.dart';

class HomeController extends BaseController {
  final _authController = Get.find<AuthenticationController>();
  final _fireController = Get.find<FirestoreController>();

  StreamSubscription? _streamSubscription;
  RxList<TaskModel> tasks = <TaskModel>[].obs;
  RxList<TaskModel> allTasks = <TaskModel>[].obs;
  List<String> categories = ['Today', 'Upcoming', 'Task Done'];
  RxInt selectedCategory = 0.obs;

  Future listenToTask() async {
    _streamSubscription = _fireController
        .streamTasks(_authController.currentUser?.userId ?? '')
        .listen((snapshots) {
      allTasks.value = snapshots;
      filterTaskByIndex(0);
    });
  }

  void filterTaskByIndex(int index) {
    switch (index) {
      case 0:
        tasks.value = allTasks.filterTodayTasks();
        break;
      case 1:
        tasks.value = allTasks.filterUpcomingTasks();
        break;
      case 2:
        tasks.value = allTasks.filterTasksByStatus(TaskStatus.done);
        break;
    }
  }



  Future markCompletedTask(String id) async {
    setBusy(true);
    final result = await _fireController.markTaskAsCompleted(
        taskId: id, uid: _authController.currentUser?.userId ?? '');
    if (!result.hasError) {
      AppUtils.showInfoMessage(message: 'Task marked as completed');
    } else {
      AppUtils.showErrorMessage(message: result.errorMessage);
    }
    setBusy(false);
    update();
  }

  void goToViewTask(TaskModel task) {
    Get.toNamed(AppRoutes.task, arguments: task);
  }

  @override
  void onInit() {
    listenToTask();
    super.onInit();
  }

  @override
  void dispose() {
    _streamSubscription?.cancel();
    super.dispose();
  }

  String getUserName() {
    return _authController.currentUser?.name ?? '';
  }
}
