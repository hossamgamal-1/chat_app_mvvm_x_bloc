import 'package:equatable/equatable.dart';

abstract class UIAuthState extends Equatable {}

class UIAuthInitial extends UIAuthState {
  @override
  List<Object?> get props => [];
}

class AuthVisibleState extends UIAuthState {
  @override
  List<Object?> get props => [];
}

class AuthInVisibleState extends UIAuthState {
  @override
  List<Object?> get props => [];
}

class SignInState extends UIAuthState {
  @override
  List<Object?> get props => [];
}

class SignUpState extends UIAuthState {
  @override
  List<Object?> get props => [];
}
