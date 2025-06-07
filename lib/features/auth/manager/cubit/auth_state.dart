part of 'auth_cubit.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}
final class AuthLoading extends AuthState {}
final class AuthSuccess extends AuthState {
  final String message;

  AuthSuccess({required this.message});
}
final class AuthFailure extends AuthState {

final String message;

  AuthFailure({required this.message});

}


final class AuthRegisterLoading extends AuthState {}
final class AuthRegisterSuccess extends AuthState {
  final String message;

  AuthRegisterSuccess({required this.message});
}
final class AuthRegisterFailure extends AuthState {

final String message;

  AuthRegisterFailure({required this.message});

}

