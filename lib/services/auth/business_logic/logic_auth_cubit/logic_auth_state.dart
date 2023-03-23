import 'package:equatable/equatable.dart';

abstract class LogicAuthState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AuthInitial extends LogicAuthState {}

class LoadingState extends LogicAuthState {}

class SuccessState extends LogicAuthState {}

class FailureState extends LogicAuthState {
  final String errorMessage;

  FailureState(this.errorMessage);
  @override
  List<Object?> get props => [errorMessage];
}
