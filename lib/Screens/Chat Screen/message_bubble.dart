import 'package:flutter/material.dart';

import '../Profile/no_image.dart';

class MsgBubble extends StatelessWidget {
  final String msg;
  final String username;
  final String userImg;
  final bool isMe;
  final Key key;

  MsgBubble({this.msg, this.username, this.userImg, this.isMe, this.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Row(
          mainAxisAlignment:
              isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            Container(
              width: 270,
              margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              child: Column(
                crossAxisAlignment:
                    isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: [
                  Text(
                    username,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Container(
                    width: 270,
                    padding: EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: isMe ? 20 : 16,
                    ),
                    decoration: BoxDecoration(
                        color: isMe
                            ? Colors.amber[100]
                            : Theme.of(context).accentColor,
                        borderRadius: BorderRadius.only(
                          topLeft:
                              isMe ? Radius.circular(8) : Radius.circular(0),
                          topRight:
                              isMe ? Radius.circular(0) : Radius.circular(8),
                          bottomLeft: Radius.circular(8),
                          bottomRight: Radius.circular(8),
                        )),
                    child: Text(
                      msg,
                      style: TextStyle(
                        fontSize: 15,
                        color: isMe
                            ? Colors.black
                            : Theme.of(context).accentTextTheme.title.color,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        Positioned(
          top: 15,
          left: isMe ? null : 255,
          right: isMe ? 260 : null,
          child: userImg != null
              ? CircleAvatar(
                  backgroundColor: Colors.grey,
                  backgroundImage: NetworkImage(userImg),
                )
              : NoImage(),
        )
      ],
    );
  }
}
