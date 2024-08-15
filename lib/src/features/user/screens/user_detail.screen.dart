import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../bloc/user_bloc.dart';

class UserDetailScreen extends StatelessWidget {
  final String userId;

  const UserDetailScreen({super.key, required this.userId});

  Future<void> _showRemoveUserDialog(BuildContext context) async {
    await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Do you want to remove this user?'),
          actions: [
            TextButton(
              onPressed: () {
                context.read<UserBloc>().add(RemoveUser(userId));
                Navigator.of(context).pop();
              },
              child: const Text('YES'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('NO'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Detail'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              _showRemoveUserDialog(context);
            },
          ),
        ],
      ),
      body: BlocListener<UserBloc, UserState>(
        listener: (context, state) {
          if (state.status.isSuccess) {
            context.goNamed('home');
          } else if (state.status.isFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Failed to remove user'),
              ),
            );
          }
        },
        child: BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            final user = state.users.cast().firstWhere(
                  (user) => user.id == userId,
                  orElse: () => null,
                );

            if (user == null) {
              return const Center(
                child: Text('User not found'),
              );
            }

            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Name: ${user.name}'),
                  Text('Email: ${user.email}'),
                  Text('Surname: ${user.surname}'),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
