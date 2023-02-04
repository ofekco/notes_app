import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:notes_app/widgets/auth_form.dart';


class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _auth = FirebaseAuth.instance;
  var _isLoading = false;

  void _submitAuthForm(String email, String password, String username, bool isLogin, BuildContext ctx) async {
    UserCredential authResult;

    try {
      setState(() {
        _isLoading = true;
      });
      if (isLogin == true) {
        authResult = await _auth.signInWithEmailAndPassword(email: email, password: password);
      } else {
        authResult = await _auth.createUserWithEmailAndPassword(email: email,password: password);
        await FirebaseFirestore.instance
            .collection('users')
            .doc(authResult.user!.uid).set({'username': username, 'email': email});
      }
    } on PlatformException catch (error) {
      var message = 'An error occurred, pelase check your credentials!';

      if (error.message != null) {
        message = error.message.toString();
      }

      showDialog(
        context: ctx, 
        builder: (ctx) => AlertDialog( title: Text('Error!'),
          content: Text(message),
          actions: <Widget>[
           TextButton(
             child: Text('OK'),
              onPressed: () { 
                Navigator.of(ctx).pop();
             },
            )
          ]
        ));
      setState(() {
        _isLoading = false;
      });
    } catch (err) {
      print(err);
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: AuthForm(
        _submitAuthForm,
        _isLoading,
      ),
    );
  }
}
