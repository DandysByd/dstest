import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../common/secure_storage.dart';
import '../services/auth.service.dart';
import 'auth_state.dart';
part 'auth_event.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final _authService = AuthService();
  final _secureStorage = SecureStorage();

  AuthBloc() : super(const AuthState()) {
    on<AuthInit>(_onAuthInit);
    on<LogIn>(_onLogIn);
    on<LogOut>(_onLogOut);
  }

  Future<void> _onAuthInit(AuthInit event, Emitter<AuthState> emit) async {
    final storedToken = await _secureStorage.readJwtToken();
    if (storedToken != null) {
      //TODO: nějaký refresh tokenu
      return emit(state.copyWith(
        loggedIn: true,
        initialized: true,
      ));
    } else {
      return emit(state.copyWith(
        loggedIn: false,
        initialized: true,
      ));
    }
  }

  Future<void> _onLogIn(LogIn event, Emitter<AuthState> emit) async {
    final login = await _authService.login(event.email, event.password);
    await _secureStorage.writeJwtToken(login["token"]);
    emit(state.copyWith(loggedIn: true));
  }

  Future<void> _onLogOut(LogOut event, Emitter<AuthState> emit) async {
    await _secureStorage.deleteJwtToken();
    emit(state.copyWith(loggedIn: false));
  }
}
