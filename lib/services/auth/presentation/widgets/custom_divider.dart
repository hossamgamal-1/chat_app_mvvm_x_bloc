import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/resources/color_manger.dart';
import '../../../../core/resources/font_manager.dart';
import '../../../../core/resources/styles_manager.dart';
import '../../../../core/resources/values_manager.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(
          child: Divider(color: ColorManager.lightPurple, thickness: 2),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: AppMargin.m10),
          child: Text(
            'OR',
            style: getRegularStyle(
                color: ColorManager.lightPurple, fontSize: FontSize.s2_8.sp),
          ),
        ),
        const Expanded(
          child: Divider(color: ColorManager.lightPurple, thickness: 2),
        ),
      ],
    );
  }
}
