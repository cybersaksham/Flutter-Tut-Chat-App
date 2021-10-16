import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../Models/routes.dart';

class MainDrawer extends StatefulWidget {
  final int curPage;
  final BuildContext ctx;

  MainDrawer(this.curPage, this.ctx);

  @override
  _MainDrawerState createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  @override
  Widget build(BuildContext context) {
    Icon iconData(var iconType) {
      return Icon(
        iconType,
        color: Theme.of(context).accentColor,
      );
    }

    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            title: Text("Chat App"),
            automaticallyImplyLeading: false,
          ),
          ListTile(
            leading: iconData(Icons.chat),
            title: Text(
              "Chats",
              style: TextStyle(
                  color: widget.curPage == 0
                      ? Theme.of(context).accentColor
                      : Colors.black),
            ),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(Routes.chat_screen);
            },
          ),
          Divider(),
          ListTile(
            leading: iconData(Icons.account_circle),
            title: Text(
              "Profile",
              style: TextStyle(
                  color: widget.curPage == 1
                      ? Theme.of(context).accentColor
                      : Colors.black),
            ),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(Routes.profile_screen);
            },
          ),
        ],
      ),
    );
  }
}
