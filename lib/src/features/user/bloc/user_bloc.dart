import 'package:bloc/bloc.dart';
import 'package:dstest/src/features/user/models/user_prototype.dart';
import 'package:equatable/equatable.dart';

import '../models/user.dart';
import '../services/user.service.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserService userService = UserService();

  UserBloc() : super(const UserState()) {
    on<FetchUsers>(_onFetchUsers);
    on<AddUser>(_onAddUser);
    on<RemoveUser>(_onRemoveUser);
  }

  Future<void> _onFetchUsers(FetchUsers event, Emitter<UserState> emit) async {
    print('fetching users');
    emit(state.copyWith(status: BlocState.loading));
    final users = await userService.fetchUsers();
    try {
      emit(state.copyWith(
        users: users,
        status: BlocState.success,
      ));
    } catch (_) {
      emit(state.copyWith(status: BlocState.failure));
    }
  }

  Future<void> _onAddUser(AddUser event, Emitter<UserState> emit) async {
    emit(state.copyWith(status: BlocState.loading));
    final user = await userService.addUser(event.user);

    try {
      emit(state.copyWith(
        users: [...state.users, user],
        status: BlocState.success,
      ));
    } catch (_) {
      emit(state.copyWith(status: BlocState.failure));
    }
  }

  Future<void> _onRemoveUser(RemoveUser event, Emitter<UserState> emit) async {
    emit(state.copyWith(status: BlocState.loading));
    var res = await userService.removeUser(event.userId);

    try {
      emit(state.copyWith(
        users: res
            ? state.users.where((u) => u.id != event.userId).toList()
            : state.users,
        status: BlocState.success,
      ));
    } catch (_) {
      emit(state.copyWith(status: BlocState.failure));
    }
  }
}
