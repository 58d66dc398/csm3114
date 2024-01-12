import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:haulier/view_login.dart';

import 'data.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _UserPageState();
  }
}

class _UserPageState extends State<UserPage> {
  final _formKey = GlobalKey<FormState>();
  final you = Data.getCurrentUser();
  String message = '';
  final Map<String, String> _body = {
    'username': '',
    'oldPassword': '',
    'password': '',
    'passwordConfirm': '',
  };
  Map<String, dynamic> _response = {};

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
    return Scaffold(
      appBar: AppBar(
        title: const Text('User'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Username'),
                initialValue: you['username'],
                onSaved: (value) => _body['username'] = value!,
                validator: (value) {
                  return (_body['username'] == '')
                      ? 'Cannot be Blank.'
                      : getErrorMessage('username');
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Old Password'),
                obscureText: true,
                onSaved: (value) => _body['oldPassword'] = value!,
                validator: (_) => getErrorMessage('oldPassword'),
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'New Password'),
                obscureText: true,
                onSaved: (value) => _body['password'] = value!,
                validator: (_) => getErrorMessage('password'),
              ),
              TextFormField(
                decoration:
                    const InputDecoration(labelText: 'Confirm Password'),
                obscureText: true,
                onSaved: (value) => _body['passwordConfirm'] = value!,
                validator: (_) => getErrorMessage('passwordConfirm'),
              ),
              Text(message),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          message = '';
          _formKey.currentState!.save();
          _response = await Data.updateUser(you['id'], _body);
          if (kDebugMode) {
            print('DEBUG : $_response');
          }
          if (_formKey.currentState!.validate()) {
            if (_response.containsKey('code') && _response['code']) {
              message = _response['message'];
            } else if (_response.isNotEmpty) {
              Data.revokeUser();
              if (context.mounted) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const LoginPage()),
                );
              }
            }
          }
          setState(() {});
        },
        label: const Text('Update'),
        icon: const Icon(Icons.edit),
      ),
    );
  }
}
