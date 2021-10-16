import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../Models/routes.dart';

class Logout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.logout),
      onPressed: () {
        FirebaseAuth.instance.signOut();
        Navigator.of(context).pushReplacementNamed(Routes.auth_screen);
      },
    );
  }
}
