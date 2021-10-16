import 'package:flutter/material.dart';

import '../Drawer/main_drawer.dart';
import '../Logout/logout.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        actions: [Logout()],
      ),
      drawer: MainDrawer(1, context),
    );
  }
}
