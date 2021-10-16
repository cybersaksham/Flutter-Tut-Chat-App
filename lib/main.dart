import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import './Screens/splash_screen.dart';
import './Screens/Chat Screen/chat_screen.dart';
import './Screens/Authentication/auth_screen.dart';
import './Screens/Profile/profile.dart';

import './Models/routes.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chat App',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        backgroundColor: Colors.pink,
        accentColor: Colors.purple,
        accentColorBrightness: Brightness.dark,
        buttonTheme: ButtonTheme.of(context).copyWith(
          buttonColor: Colors.pink,
          textTheme: ButtonTextTheme.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.onAuthStateChanged,
        builder: (ctx, userSnapshot) {
          if (userSnapshot.connectionState == ConnectionState.waiting) {
            return SplashScreen();
          }
          if (userSnapshot.hasData) {
            return ChatScreen();
          }
          return AuthScreen();
        },
      ),
      routes: {
        Routes.auth_screen: (ctx) => AuthScreen(),
        Routes.chat_screen: (ctx) => ChatScreen(),
        Routes.profile_screen: (ctx) => ProfileScreen(),
      },
    );
  }
}
