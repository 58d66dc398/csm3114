import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:haulier/view_home.dart';

import 'data.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final Map<String, String> _body = {
    'username': '',
    'password': '',
    'passwordConfirm': '',
  };
  Map<String, dynamic> _response = {};
  bool register = false;
  String message = '';

  String? getErrorMessage(String key) {
    String? message;
    if (_response.containsKey('data')) {
      Map<String, dynamic> data = _response['data'];
      message = (data.containsKey(key)) ? data[key]!['message'] : null;
    }
    return message;
  }

  @override
  Widget build(BuildContext context) {
    if (Data.isLoggedIn()) {
      // https://stackoverflow.com/questions/54846280
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        await pb.collection("users").authRefresh();
        await Data.loadTrucks();
        await Data.loadSchedules();
        if (context.mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const HomePage()),
          );
        }
      });
    }

    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(32),
        child: Form(
          key: _formKey,
          child: Wrap(
            alignment: WrapAlignment.center,
            runSpacing: 16,
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Username'),
                validator: (value) {
                  String? error;
                  if (_body['username'] == '') {
                    error = 'Cannot be Blank.';
                  } else {
                    error = (register)
                        ? getErrorMessage('username')
                        : getErrorMessage('identity');
                  }
                  return error;
                },
                onSaved: (value) => _body['username'] = value!,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Password'),
                validator: (_) => getErrorMessage('password'),
                onSaved: (value) => _body['password'] = value!,
              ),
              TextFormField(
                decoration:
                    const InputDecoration(labelText: 'Confirm Password'),
                validator: (_) =>
                    (register) ? getErrorMessage('passwordConfirm') : null,
                onSaved: (value) => _body['passwordConfirm'] = value!,
              ),
              ButtonBar(
                alignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      message = '';
                      register = false;
                      _formKey.currentState!.save();
                      _response = await Data.authUser(_body);
                      if (_formKey.currentState!.validate()) {
                        if (_response['code'] == 200) {
                          _formKey.currentState!.reset();
                        } else if (_response.isNotEmpty) {
                          message = _response['message'];
                          if (kDebugMode) {
                            print('DEBUG: $message');
                          }
                        }
                      }
                      setState(() {});
                    },
                    child: const Text('Login'),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      message = '';
                      register = true;
                      _formKey.currentState!.save();
                      _response = await Data.addUser(_body);
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.reset();
                        message = 'Successfully created account.';
                        if (kDebugMode) {
                          print('DEBUG: $message');
                        }
                      }
                      setState(() {});
                    },
                    child: const Text('Register'),
                  ),
                ],
              ),
              Text(message),
            ],
          ),
        ),
      ),
    );
  }
}
