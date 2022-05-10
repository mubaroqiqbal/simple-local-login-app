part of 'auth_bloc_cubit.dart';

abstract class AuthBlocState extends Equatable {
  const AuthBlocState();

  @override
  List<Object> get props => [];
}

class AuthBlocInitialState extends AuthBlocState {}

class AuthBlocLoadingState extends AuthBlocState {}

class AuthBlocLoggedInState extends AuthBlocState {}

class AuthBlocLoginState extends AuthBlocState {}

class AuthBlocSuccesState extends AuthBlocState {}

class AuthBlocRegisterSuccesState extends AuthBlocState {}

class AuthBlocRegisterErrorState extends AuthBlocState {
  final error;

  AuthBlocRegisterErrorState(this.error);

  @override
  List<Object> get props => [error];
}

class AuthBlocErrorState extends AuthBlocState {
  final error;

  AuthBlocErrorState(this.error);

  @override
  List<Object> get props => [error];
}
