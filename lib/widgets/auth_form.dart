import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  AuthForm(
    this.submitFn,
    this.isLoading,
  );

  final bool isLoading;
  final void Function(String email, String password, String userName, bool isLogin, BuildContext ctx) submitFn;

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  var _isLogin = true;
  var _userEmail = '';
  var _userName = '';
  var _userPassword = '';

  void _trySubmit() {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();

    if (isValid) {
      _formKey.currentState!.save();
      widget.submitFn(_userEmail.trim(), _userPassword.trim(), _userName.trim(),
          _isLogin, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  TextFormField(
                    style: const TextStyle(color: Color(0xFF444444)),
                    key: const ValueKey('email'),
                    validator: (value) {
                      if (value == null || value.isEmpty || !value.contains('@')) {
                        return 'Please enter a valid email address.';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      labelText: 'Email address',
                    ),
                    onSaved: (value) {
                      _userEmail = value.toString();
                    },
                  ),
                  if (!_isLogin)
                    TextFormField(
                      style: const TextStyle(color: Color(0xFF444444)),
                      key: const ValueKey('username'),
                      validator: (value) {
                        if (value == null || value.isEmpty || value.length < 3) {
                          return 'Please enter at least 3 characters';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(labelText: 'Username'),
                      onSaved: (value) {
                        _userName = value.toString();
                      },
                    ),
                  TextFormField(
                    style: const TextStyle(color: Color(0xFF444444)),
                    key: const ValueKey('password'),
                    validator: (value) {
                      if (value == null || value.isEmpty || value.length < 6) {
                        return 'Password must be at least 6 characters';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(labelText: 'Password'),
                    obscureText: true,
                    onSaved: (value) {
                      _userPassword = value.toString();
                    },
                  ),
                  const SizedBox(height: 12),
                  if (widget.isLoading) 
                    const CircularProgressIndicator(),
                  if (!widget.isLoading)
                    ElevatedButton(
                      child: Text(_isLogin ? 'Login' : 'Signup', 
                        style: TextStyle(color: Color(0xFF444444),)
                      ),
                      style: ElevatedButton.styleFrom(
                       backgroundColor: Theme.of(context).primaryColor,
                       padding: EdgeInsets.symmetric(
                          horizontal: 30.0, vertical: 8.0),
                       shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        )),
                      onPressed: _trySubmit,
                    ),
                  if (!widget.isLoading)
                    TextButton(
                      child: Text(_isLogin ? 'Don\'t have an account? Signup!' : 'I already have an account',
                          style: const TextStyle(color: Color(0xFF444444)),
                        ),
                      onPressed: () {
                        setState(() {
                          _isLogin = !_isLogin;
                        });
                      },
                    )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
