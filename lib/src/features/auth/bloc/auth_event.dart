part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  @override
  List<Object> get props => [];
}

final class AuthInit extends AuthEvent {}

final class LogIn extends AuthEvent {
  final String email;
  final String password;

  LogIn({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}

final class LogOut extends AuthEvent {}
