import 'package:flutter/material.dart';

class NoImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: Colors.grey,
      child: IconButton(
        icon: Icon(Icons.account_circle_rounded),
        onPressed: null,
        color: Colors.white,
      ),
    );
  }
}
