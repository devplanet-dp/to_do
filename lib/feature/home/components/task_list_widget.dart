import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do/core/shared/app_styles.dart';
import 'package:to_do/core/widgets/app_info.dart';
import 'package:to_do/feature/home/components/task_tile.dart';

import '../../../data/model/task_model.dart';

class TaskListWidget extends StatelessWidget {
  const TaskListWidget(
      {Key? key,
      required this.tasks,
      required this.onSelected,
      required this.onMarkCompleted})
      : super(key: key);
  final List<TaskModel> tasks;
  final Function(TaskModel) onSelected;
  final Function(String) onMarkCompleted;

  @override
  Widget build(BuildContext context) {
    return tasks.isEmpty
        ? const AppInfoWidget(
                translateKey: 'No any tasks found!', iconData: Icons.add_task)
            .paddingAll(24)
        : ListView.separated(
            itemCount: tasks.length,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            separatorBuilder: (_, __) => AppStyles.vSpaceMedium,
            itemBuilder: (_, index) => InkWell(
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                  onTap: () => onSelected(tasks[index]),
                  child: TaskTile(
                    task: tasks[index],
                    onMarkCompleted: onMarkCompleted,
                  ),
                ));
  }
}
