import 'dart:io';

import 'package:chat_app/data/web_services.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../presentation/auth_screen.dart';
import '../presentation/widgets/text_field.dart';

class AuthProvider with ChangeNotifier {
/////////////////////////////////////////////////////////////////
///////////////////// Auth UI States ////////////////////////////
/////////////////////////////////////////////////////////////////

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String? userName;
  String? emailAddress;
  String? password;
  IconData eye = Icons.visibility_off;
  bool secured = true;
  AuthMode authMode = AuthMode.signIn;

  AuthProvider(this.webServices);

  void switchMode() {
    authMode = authMode == AuthMode.signIn ? AuthMode.signUp : AuthMode.signIn;
    notifyListeners();
    CustomTextField.userNameController.clear();
    CustomTextField.repeatPasswordController.clear();
  }

  void eyeToggle() {
    eye = eye == Icons.visibility_off ? Icons.visibility : Icons.visibility_off;
    secured = !secured;
    notifyListeners();
  }

/////////////////////////////////////////////////////////////////
////////////////////// Image Picker /////////////////////////////
/////////////////////////////////////////////////////////////////

  File? image;
  void getImage(ImageSource route) async {
    final XFile? pickedImage = await ImagePicker().pickImage(source: route);
    if (pickedImage != null) {
      image = File(pickedImage.path);
      notifyListeners();
    }
  }

/////////////////////////////////////////////////////////////////
//////////////////// Auth Logic State ///////////////////////////
/////////////////////////////////////////////////////////////////

  bool isLoading = false;
  String? idToken;
  String? localId;
  DateTime? expiresIn;

  String currentUserUID = '';

  loadingSetter(bool value) {
    isLoading = value;
    notifyListeners();
  }

  _cachingUid(String uid) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('currentUserUID', uid);
  }

  final WebServices webServices;

  signIn() async {
    if (userName != null && emailAddress != null && password != null) {
      String uid = await webServices.signInWithEmailAndPassword(
        userName: userName!,
        emailAddress: emailAddress!,
        password: password!,
      );
      notifyListeners();
      _cachingUid(uid);
    }
  }

  signUp() async {
    if (userName != null && emailAddress != null && password != null) {
      webServices.signUpWithEmailAndPassword(
        emailAddress: emailAddress!,
        password: password!,
      );
    }
  }

  getCurrentUserUID() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    currentUserUID = prefs.getString('currentUserUID') ?? '';
  }
}
