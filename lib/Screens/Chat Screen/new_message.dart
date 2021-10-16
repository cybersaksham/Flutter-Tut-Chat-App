import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NewMessage extends StatefulWidget {
  @override
  _NewMessageState createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  String _enteredMsg = "";
  final _enteredMsgController = new TextEditingController();

  void _sendMsg() async {
    // FocusScope.of(context).unfocus();
    setState(() {
      _enteredMsg = "";
    });
    final user = await FirebaseAuth.instance.currentUser();
    final userData = await Firestore.instance
        .collection(
          'users',
        )
        .document(user.uid)
        .get();
    Firestore.instance.collection('chats').add({
      'text': _enteredMsgController.text,
      'createdAt': Timestamp.now(),
      'userId': user.uid,
      'username': userData['username'],
      'userImg': userData['imgUrl'],
    });
    _enteredMsgController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.all(8),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              textCapitalization: TextCapitalization.sentences,
              controller: _enteredMsgController,
              decoration: InputDecoration(labelText: "Send a message..."),
              onChanged: (val) {
                setState(() {
                  _enteredMsg = val;
                });
              },
            ),
          ),
          IconButton(
            icon: Icon(Icons.send),
            color: Theme.of(context).primaryColor,
            onPressed: _enteredMsg.trim().isEmpty ? null : _sendMsg,
          ),
        ],
      ),
    );
  }
}
