// ignore_for_file: file_names

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../data/web_services.dart';
import 'logic_auth_state.dart';

class LogicAuthCubit extends Cubit<LogicAuthState> {
  LogicAuthCubit(this.baseWebServices) : super(AuthInitial());

  String? idToken;
  String? localId;
  DateTime? expiresIn;
  String currentUserUID = '';
  final BaseWebServices baseWebServices;

  Future<void> signIn(
      {required String userName,
      required String emailAddress,
      required String password}) async {
    try {
      emit(LoadingState());
      String uid = await baseWebServices.signInWithEmailAndPassword(
          emailAddress: emailAddress, password: password);
      await _cachingUid(uid);

      emit(SuccessState());
    } catch (e) {
      emit(FailureState(e.toString()));
    }
  }

  Future<void> signUp(
      {required String userName,
      required String emailAddress,
      required String password}) async {
    try {
      emit(LoadingState());
      baseWebServices.signUpWithEmailAndPassword(
          emailAddress: emailAddress, password: password);
      emit(SuccessState());
    } catch (e) {
      emit(FailureState(e.toString()));
    }
  }

  Future<void> _cachingUid(String uid) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isAdded = await prefs.setString('currentUserUID', uid);
    isAdded
        ? debugPrint('currentUserUID is Added successfully')
        : debugPrint('currentUserUID is not Added');
  }

  Future<void> getCurrentUserUID() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    currentUserUID = prefs.getString('currentUserUID') ?? '';
  }

  @override
  void onChange(Change<LogicAuthState> change) {
    debugPrint(change.toString());
    super.onChange(change);
  }
}
