import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../bloc/user_bloc.dart';

class UsersWidget extends StatefulWidget {
  const UsersWidget({super.key});

  @override
  State<UsersWidget> createState() => _UsersWidgetState();
}

class _UsersWidgetState extends State<UsersWidget>
    with AutomaticKeepAliveClientMixin<UsersWidget> {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Material(
      child: Scrollable(viewportBuilder: (context, offset) {
        return BlocBuilder<UserBloc, UserState>(builder: (context, state) {
          if (state.status.isInitial) {
            return const CircularProgressIndicator();
          } else if (state.status.isFailure) {
            return const Text('Failed to fetch users');
          } else {
            return ListView.builder(
                shrinkWrap: true,
                itemCount: state.users.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(state.users[index].name),
                    subtitle: Text(state.users[index].email),
                    onTap: () {
                      context.go('/users/${state.users[index].id}');
                    },
                  );
                });
          }
        });
      }),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
