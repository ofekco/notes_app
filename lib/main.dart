import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/screens/auth_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:notes_app/screens/home_screen.dart';
import 'package:notes_app/screens/splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();  
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  
  @override
  Widget build(BuildContext context) {

    final Future<FirebaseApp> _initialization = Firebase.initializeApp();
    return FutureBuilder(
      future: _initialization,
      builder: (context, appSnapshot) {
        return MaterialApp(
          title: 'Notes',
          theme: ThemeData( 
            primaryColor: Color(0xFFE6D1CB),
            secondaryHeaderColor: Color(0xFFEEEDE7),
            buttonTheme: ButtonTheme.of(context).copyWith(
              buttonColor: Color(0xFFE7D2CC),
              textTheme: ButtonTextTheme.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
          home: appSnapshot.connectionState != ConnectionState.done ? SplashScreen() : 
            StreamBuilder(stream: FirebaseAuth.instance.authStateChanges(), builder: (ctx, userSnapshot) {
          if (userSnapshot.connectionState == ConnectionState.waiting) {
            return SplashScreen();
          }
          if (userSnapshot.hasData) {
            return HomeScreen();
          }
          return AuthScreen();
         }
        )
      );

    });
      
  }
}
       








