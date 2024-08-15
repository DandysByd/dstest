import 'package:go_router/go_router.dart';
import '../../main.dart';
import '../features/salary/widgets/salaries.widget.dart';
import '../features/user/screens/add_user.screen.dart';
import '../features/user/screens/user_detail.screen.dart';

final appRouter = GoRouter(
  routes: [
    GoRoute(
      name: 'users',
      path: '/users',
      builder: (context, state) => const MyHomePage(title: 'Users/Paychecks'),
      routes: [
        GoRoute(
          name: 'addUser',
          path: 'add',
          builder: (context, state) => const AddUserScreen(),
        ),
        GoRoute(
          name: 'userDetail',
          path: ':userId',
          builder: (context, state) {
            final id = state.pathParameters['userId']!;
            return UserDetailScreen(userId: id);
          },
        ),
      ],
    ),
    GoRoute(
      name: 'salaries',
      path: '/salaries',
      builder: (context, state) => const SalariesWidget(),
    ),
    GoRoute(
      name: 'home',
      path: '/',
      redirect: (context, state) => '/users',
    ),
  ],
);
