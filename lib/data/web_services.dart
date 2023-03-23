import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';

class WebServices {
  Future<String> signInWithEmailAndPassword(
      {required String userName,
      required String emailAddress,
      required String password}) async {
    UserCredential userCredential =
        await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: emailAddress,
      password: password,
    );
    return userCredential.user!.uid;
  }

  signUpWithEmailAndPassword(
      {required String emailAddress, required String password}) async {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress, password: password);
  }
}
