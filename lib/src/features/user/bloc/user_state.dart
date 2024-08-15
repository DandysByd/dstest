part of 'user_bloc.dart';

enum BlocState { initial, loading, success, failure }

extension Status on BlocState {
  bool get isInitial => this == BlocState.initial;
  bool get isLoading => this == BlocState.loading;
  bool get isSuccess => this == BlocState.success;
  bool get isFailure => this == BlocState.failure;
}

final class UserState extends Equatable {
  final List<User> users;
  final BlocState status;

  const UserState({this.users = const [], this.status = BlocState.initial});

  UserState copyWith({
    List<User>? users,
    BlocState? status,
  }) {
    return UserState(
      users: users ?? this.users,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [users, status];
}
