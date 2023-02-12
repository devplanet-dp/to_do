import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do/core/routes/app_routes.dart';
import 'package:to_do/core/shared/app_colors.dart';
import 'package:to_do/core/shared/app_styles.dart';
import 'package:to_do/core/widgets/sliver_app_bar.dart';
import 'package:to_do/feature/home/components/task_list_widget.dart';
import 'package:to_do/feature/home/home_controller.dart';

import 'components/status_selection_bar_widget.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({Key? key}) : super(key: key);

  Widget _buildFab() => FloatingActionButton(
        backgroundColor: AppColors.kcAccent,
        elevation: 5,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12))),
        child: const Icon(
          Icons.add,
          color: AppColors.kcPrimaryColor,
        ),
        onPressed: () => Get.toNamed(AppRoutes.task),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: _buildFab(),
      backgroundColor: AppColors.kAltWhite,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: CustomScrollView(
        slivers: [
          CustomSliverAppBar(title: 'Hello! ${controller.getUserName()}'),
          SliverList(
              delegate: SliverChildListDelegate([
            AppStyles.vSpaceMedium,
            Obx(() => StatusSelectionBar(
                  selectedCategoryIndex: controller.selectedCategory.value,
                  onSelected: (index) {
                    controller.selectedCategory.value = index;
                    controller.filterTaskByIndex(index);
                  },
                  categories: controller.categories,
                )),
            Obx(() => TaskListWidget(
                tasks: controller.tasks.value,
                onSelected: controller.goToViewTask,
                onMarkCompleted: controller.markCompletedTask,
                )),
            AppStyles.vSpaceMassive,
          ]))
        ],
      ),
    );
  }
}
