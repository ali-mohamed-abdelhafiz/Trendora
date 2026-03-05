part of 'auth_cubit.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthLoadingState extends AuthState {}

final class AuthSuccesState extends AuthState {
  final String message;

  AuthSuccesState(this.message);
}

final class AuthFailureState extends AuthState {
  final String message;

  AuthFailureState(this.message);
}
