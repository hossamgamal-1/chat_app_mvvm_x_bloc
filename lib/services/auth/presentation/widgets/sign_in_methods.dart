import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/resources/values_manager.dart';

class SignInMethods extends StatelessWidget {
  const SignInMethods({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 5.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          for (int i = 0; i < 3; i++)
            Container(
              margin: const EdgeInsets.symmetric(
                  horizontal: AppMargin.m5, vertical: AppMargin.m10),
              padding: EdgeInsets.zero,
              width: AppPadding.p13.w,
              height: AppPadding.p13.w,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
              ),
            )
        ],
      ),
    );
  }
}
