import 'package:equatable/equatable.dart';

final class AuthState extends Equatable {
  final bool loggedIn;
  final bool initialized;

  const AuthState({
    this.loggedIn = false,
    this.initialized = false,
  });

  AuthState copyWith({
    bool? loggedIn,
    bool? initialized,
  }) {
    return AuthState(
      loggedIn: loggedIn ?? this.loggedIn,
      initialized: initialized ?? this.initialized,
    );
  }

  @override
  List<Object?> get props => [loggedIn, initialized];
}
