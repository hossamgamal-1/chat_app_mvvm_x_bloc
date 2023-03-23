import 'package:firebase_auth/firebase_auth.dart';

abstract class BaseWebServices {
  Future<String> signInWithEmailAndPassword(
      {required String emailAddress, required String password});
  Future<void> signUpWithEmailAndPassword(
      {required String emailAddress, required String password});
}

class WebServices implements BaseWebServices {
  @override
  Future<String> signInWithEmailAndPassword(
      {required String emailAddress, required String password}) async {
    final userCredential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: emailAddress, password: password);
    return userCredential.user!.uid;
  }

  @override
  Future<void> signUpWithEmailAndPassword(
      {required String emailAddress, required String password}) async {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress, password: password);
  }
}
