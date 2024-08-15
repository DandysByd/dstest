import 'package:dstest/src/features/auth/bloc/auth_bloc.dart';
import 'package:dstest/src/features/auth/bloc/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/salary_bloc.dart';
import '../bloc/salary_state.dart';

class SalariesWidget extends StatefulWidget {
  const SalariesWidget({super.key});

  @override
  State<SalariesWidget> createState() => _SalariesWidgetState();
}

class _SalariesWidgetState extends State<SalariesWidget> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, String> _formData = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state.loggedIn) {
              context.read<SalaryBloc>().add(FetchSalaries());
            }
          },
          builder: (context, state) {
            if (state.loggedIn) {
              return BlocBuilder<SalaryBloc, SalaryState>(
                builder: (context, state) {
                  return ListView.builder(
                      itemCount: state.salaries.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(state.salaries[index].money.toString()),
                          subtitle:
                              Text(state.salaries[index].month.toString()),
                        );
                      });
                },
              );
            } else {
              return SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'Email',
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null || !value.contains('@')) {
                              return 'Invalid email';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            if (value != null) {
                              _formData['email'] = value;
                            }
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'Password',
                            border: OutlineInputBorder(),
                          ),
                          obscureText: true,
                          validator: (value) {
                            if (value == null || value.length < 10) {
                              return 'Password must be at least 10 characters long';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            if (value != null) {
                              _formData['password'] = value;
                            }
                          },
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState?.validate() ?? false) {
                            _formKey.currentState?.save();
                            context.read<AuthBloc>().add(
                                  LogIn(
                                    email: _formData['email'] ?? '',
                                    password: _formData['password'] ?? '',
                                  ),
                                );
                          }
                        },
                        child: const Text('Log In'),
                      ),
                    ],
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
