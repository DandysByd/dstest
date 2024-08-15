import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../bloc/user_bloc.dart';
import '../models/user_prototype.dart';

class InputPair {
  final String label;
  final bool isObscure;
  final bool mandatory;
  final String? Function(String?)? validator;

  InputPair(
    this.label,
    this.isObscure,
    this.mandatory, {
    this.validator,
  });
}

class AddUserScreen extends StatefulWidget {
  const AddUserScreen({Key? key}) : super(key: key);

  @override
  _AddUserScreenState createState() => _AddUserScreenState();
}

class _AddUserScreenState extends State<AddUserScreen> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, String> _formData = {};

  static final List<InputPair> inputs = [
    InputPair('Name', false, true),
    InputPair('Surname', false, true),
    InputPair('Email', false, true, validator: (value) {
      if (value == null || !value.contains('@')) {
        return 'Invalid email';
      }
      return null;
    }),
    InputPair('Password', true, true, validator: (value) {
      if (value == null || value.length < 10) {
        return 'Password must be at least 10 characters long';
      }
      return null;
    }),
    InputPair('Note', false, false),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: const Text('Add User'),
      ),
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.8,
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                ...inputs.map((input) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: input.label,
                        border: const OutlineInputBorder(),
                      ),
                      obscureText: input.isObscure,
                      validator: input.validator,
                      onSaved: (value) {
                        if (value != null) {
                          _formData[input.label] = value;
                        }
                      },
                    ),
                  );
                }),
                BlocBuilder<UserBloc, UserState>(
                  builder: (context, state) {
                    return ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState?.validate() ?? false) {
                          _formKey.currentState?.save();
                          final userPrototype = UserPrototype(
                            name: _formData['Name'] ?? 'string',
                            surname: _formData['Surname'] ?? 'string',
                            email: _formData['Email'] ?? '',
                            plainPassword: _formData['Password'] ?? 'string',
                            note: _formData['Note'] ?? 'anything',
                            active: true,
                          );
                          context.read<UserBloc>().add(AddUser(userPrototype));
                          state.status.isSuccess
                              ? context.goNamed('home')
                              : ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Failed to add user'),
                                  ),
                                );
                        }
                      },
                      child: const Text('Add User'),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
