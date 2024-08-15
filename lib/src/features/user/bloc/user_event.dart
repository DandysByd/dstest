part of 'user_bloc.dart';

sealed class UserEvent extends Equatable {
  const UserEvent();
}

final class FetchUsers extends UserEvent {
  const FetchUsers();

  @override
  List<Object> get props => [];
}

final class AddUser extends UserEvent {
  final UserPrototype user;

  const AddUser(this.user);

  @override
  List<Object> get props => [user];
}

final class RemoveUser extends UserEvent {
  final String userId;

  const RemoveUser(this.userId);

  @override
  List<Object> get props => [userId];
}
