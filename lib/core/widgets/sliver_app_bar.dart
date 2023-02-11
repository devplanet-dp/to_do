import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do/core/shared/app_styles.dart';

import '../shared/app_colors.dart';

class CustomSliverAppBar extends StatelessWidget {
  final String title;
  final bool showLeading;
  final Widget? subtitle;
  final bool isAdminBar;

  const CustomSliverAppBar({
    Key? key,
    required this.title,
    this.showLeading = true,
    this.subtitle,
    this.isAdminBar = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: false,
      expandedHeight: Get.height * 0.23,
      backgroundColor: AppColors.kcPrimaryColor,
      iconTheme: const IconThemeData(color: Colors.white),
      flexibleSpace: Stack(
        children: [
          Positioned.fill(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  const SizedBox(height: kToolbarHeight,),
                  _buildHeader(),
                  Text(
                    title,
                    style: AppStyles.kSubheadingStyle.copyWith(
                        color: Colors.white, fontWeight: FontWeight.w700),
                  ).paddingOnly(left: 15),
                  AppStyles.vSpaceSmall,
                ],
              ),
            ),
          ),
          Positioned(
            bottom: -1,
            left: 0,
            right: 0,
            child: Container(
              height: 15,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(AppStyles.kRadiusLarge),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Row _buildHeader() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        AppStyles.hSpaceSmall,
        // Image.asset(
        //   ,
        //   height: 32,
        //   width: 32,
        // ),
        AppStyles.hSpaceSmall,
        Text(
          'ToDo',
          style: AppStyles.kBody1Style.copyWith(
              color: Colors.white, fontWeight: FontWeight.w700),
        ),
        AppStyles.hSpaceSmall,
      ],
    );
  }
}
