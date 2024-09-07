part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

class SignupButtonPressedEvent extends AuthEvent {
  final String username;
  final String email;
  final String password;

  SignupButtonPressedEvent({
    required this.username,
    required this.email,
    required this.password,
  });
}

class SigninButtonPressedEvent extends AuthEvent {
  final String email;
  final String password;

  SigninButtonPressedEvent({
    required this.email,
    required this.password,
  });
}
