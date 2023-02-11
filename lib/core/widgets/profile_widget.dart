import 'package:flutter/material.dart';
import 'package:styled_widget/styled_widget.dart';

import '../shared/app_styles.dart';

class ProfileWidget extends StatelessWidget {
  final bool? isDark;
  final String name;

  const ProfileWidget({Key? key, this.isDark = false, required this.name})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      width: 48,
      decoration: BoxDecoration(
          color: Colors.red.withOpacity(.5),
          borderRadius: const BorderRadius.all(Radius.circular(8))),
      child: _buildLetter(context).center(),
    );
  }

  Widget _buildLetter(BuildContext context) => Text(
        name[0].toUpperCase(),
        style: AppStyles.kHeadlineStyle.copyWith(color: Colors.white),
      );
}
