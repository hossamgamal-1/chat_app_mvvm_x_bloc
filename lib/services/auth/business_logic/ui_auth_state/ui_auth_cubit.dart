import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/enums.dart';
import '../../presentation/widgets/text_field.dart';
import 'ui_auth_state.dart';

class UIAuthCubit extends Cubit<UIAuthState> {
  UIAuthCubit() : super(UIAuthInitial());

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String? userName;
  String? emailAddress;
  String? password;
  IconData eye = Icons.visibility_off;
  bool secured = true;
  AuthMode authMode = AuthMode.signIn;

  void switchMode() {
    CustomTextField.userNameController.clear();
    CustomTextField.repeatPasswordController.clear();
    if (authMode == AuthMode.signIn) {
      authMode = AuthMode.signUp;
      emit(SignUpState());
    } else {
      authMode = AuthMode.signIn;
      emit(SignInState());
    }
  }

  void eyeToggle() {
    secured = !secured;
    if (eye == Icons.visibility_off) {
      eye = Icons.visibility;
      emit(AuthVisibleState());
    } else {
      eye = Icons.visibility_off;
      emit(AuthInVisibleState());
    }
  }

  File? image;
  void getImage(ImageSource route) async {
    final XFile? pickedImage = await ImagePicker().pickImage(source: route);
    if (pickedImage != null) {
      image = File(pickedImage.path);
      emit(UIAuthInitial());
    }
  }
}
