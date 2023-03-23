import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/enums.dart';
import '../../business_logic/ui_auth_state/ui_auth_cubit.dart';

class PickImage extends StatelessWidget {
  const PickImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UIAuthCubit watch = context.watch<UIAuthCubit>();
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      constraints: BoxConstraints(
        minHeight: watch.authMode == AuthMode.signUp ? 15.h : 0,
        maxHeight: watch.authMode == AuthMode.signUp ? 15.h : 0,
      ),
      child: FittedBox(
        child: Column(
          children: [
            CircleAvatar(
              radius: 7.w,
              backgroundColor: const Color(0xff8E94FF),
              backgroundImage:
                  watch.image != null ? FileImage(watch.image!) : null,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                imageGetter(
                  context,
                  ImageSource.camera,
                  'Add Image From Camera',
                  Icons.camera_alt_outlined,
                ),
                imageGetter(
                  context,
                  ImageSource.gallery,
                  'Add Image From Gallery',
                  Icons.photo,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  TextButton imageGetter(
    BuildContext context,
    ImageSource route,
    String text,
    IconData icon,
  ) {
    return TextButton.icon(
      onPressed: () => context.read<UIAuthCubit>().getImage(route),
      icon: Icon(icon, color: Colors.white),
      label: Container(
          constraints: BoxConstraints(maxWidth: 20.w),
          child: Text(text, style: const TextStyle(color: Colors.white))),
    );
  }
}
