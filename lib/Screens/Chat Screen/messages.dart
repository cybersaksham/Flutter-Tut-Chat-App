import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import './message_bubble.dart';

import '../../Models/loader.dart';

class Messages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirebaseAuth.instance.currentUser(),
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Loader();
        }
        return StreamBuilder(
            stream: Firestore.instance
                .collection('chats')
                .orderBy('createdAt', descending: true)
                .snapshots(),
            builder: (ctx, chatSnapshot) {
              if (chatSnapshot.connectionState == ConnectionState.waiting) {
                return Loader();
              }
              final chatDocs = chatSnapshot.data.documents;
              return ListView.builder(
                  reverse: true,
                  itemCount: chatDocs.length,
                  itemBuilder: (ctx, i) {
                    return MsgBubble(
                      msg: chatDocs[i]['text'],
                      username: chatDocs[i]['username'],
                      userImg: chatDocs[i]['userImg'],
                      isMe: chatDocs[i]['userId'] == snapshot.data.uid,
                      key: ValueKey(chatDocs[i].documentID),
                    );
                  });
            });
      },
    );
  }
}
