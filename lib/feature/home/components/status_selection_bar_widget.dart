import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do/core/shared/app_colors.dart';
import 'package:to_do/core/shared/app_styles.dart';

class StatusSelectionBar extends StatelessWidget {
  const StatusSelectionBar(
      {Key? key,
      required this.selectedCategoryIndex,
      required this.onSelected,
      required this.categories})
      : super(key: key);

  final int selectedCategoryIndex;
  final Function(int) onSelected;
  final List<String> categories;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(categories.length, (index) {
        final selected = selectedCategoryIndex == index;
        return ChoiceChip(
                label: Text(
                  categories[index],
                  style: AppStyles.kCaptionStyle.copyWith(
                    fontWeight: selected ? FontWeight.w800 : FontWeight.w500,
                    color: selected?Colors.white:AppColors.kcPrimaryColor
                  ),
                ),
                onSelected: (value) {
                  onSelected(index);
                },
                selected: selected)
            .paddingOnly(right: 8);
      }),
    );
  }
}
