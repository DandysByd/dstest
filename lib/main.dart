import 'package:dstest/src/common/app.router.dart';
import 'package:dstest/src/features/auth/bloc/auth_bloc.dart';
import 'package:dstest/src/features/salary/bloc/salary_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:dstest/src/features/salary/widgets/salaries.widget.dart';
import 'package:dstest/src/features/user/bloc/user_bloc.dart';
import 'package:dstest/src/features/user/widgets/users.widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<UserBloc>(
          create: (context) => UserBloc()..add(const FetchUsers()),
        ),
        BlocProvider<SalaryBloc>(
          create: (context) => SalaryBloc(),
        ),
        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc()..add(AuthInit()),
        ),
      ],
      child: MaterialApp.router(
        routerConfig: appRouter,
        title: 'User/Salary view',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        actions: [
          Visibility(
            visible: context.select((AuthBloc bloc) => bloc.state.loggedIn),
            child: IconButton(
              onPressed: () {
                context.read<AuthBloc>().add(LogOut());
              },
              icon: const Icon(Icons.logout),
            ),
          ),
        ],
      ),
      body: const DefaultTabController(
        length: 2,
        child: Column(
          children: [
            TabBar(
              tabs: [
                Tab(icon: Icon(Icons.accessibility_sharp)),
                Tab(icon: Icon(Icons.monetization_on)),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  UsersWidget(),
                  SalariesWidget(),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.goNamed('addUser');
        },
        tooltip: 'Add User',
        child: const Icon(Icons.add),
      ),
    );
  }
}
