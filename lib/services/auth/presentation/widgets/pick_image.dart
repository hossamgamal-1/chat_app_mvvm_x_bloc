import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';

import '../../business_logic/auth_provider.dart';
import '../auth_screen.dart';

class PickImage extends StatelessWidget {
  const PickImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      constraints: BoxConstraints(
        minHeight: context.watch<AuthProvider>().authMode == AuthMode.signUp
            ? 15.h
            : 0,
        maxHeight: context.watch<AuthProvider>().authMode == AuthMode.signUp
            ? 15.h
            : 0,
      ),
      child: FittedBox(
        child: Column(
          children: [
            CircleAvatar(
              radius: 7.w,
              backgroundColor: const Color(0xff8E94FF),
              backgroundImage: context.watch<AuthProvider>().image != null
                  ? FileImage(context.watch<AuthProvider>().image!)
                  : null,
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
      onPressed: () => context.read<AuthProvider>().getImage(route),
      icon: Icon(icon, color: Colors.white),
      label: Container(
          constraints: BoxConstraints(maxWidth: 20.w),
          child: Text(text, style: const TextStyle(color: Colors.white))),
    );
  }
}
