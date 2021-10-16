import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import './no_image.dart';

class ProfileImage extends StatefulWidget {
  File imgChosen;
  final void Function(File) imagePickFn;

  ProfileImage(this.imgChosen, this.imagePickFn);

  @override
  _ProfileImageState createState() => _ProfileImageState();
}

class _ProfileImageState extends State<ProfileImage> {
  void _pickImg(int choice) async {
    final pickedImgFile = await ImagePicker.pickImage(
      source: choice == 1 ? ImageSource.camera : ImageSource.gallery,
      imageQuality: 50,
      maxWidth: 150,
    );
    setState(() {
      if (pickedImgFile != null) {
        widget.imgChosen = pickedImgFile;
      }
    });
    widget.imagePickFn(widget.imgChosen);
  }

  void _chooseOptionToPick() {
    showModalBottomSheet(
        context: context,
        builder: (ctx) => Container(
              margin: EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  FlatButton.icon(
                    icon: Icon(Icons.camera_alt, size: 40),
                    onPressed: () {
                      Navigator.of(ctx).pop();
                      _pickImg(1);
                    },
                    label: Text("Camera"),
                    textColor: Theme.of(context).accentColor,
                  ),
                  FlatButton.icon(
                    icon: Icon(Icons.photo, size: 40),
                    onPressed: () {
                      Navigator.of(ctx).pop();
                      _pickImg(2);
                    },
                    label: Text("Gallery"),
                    textColor: Theme.of(context).accentColor,
                  ),
                ],
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      width: 70,
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(35),
      ),
      child: widget.imgChosen != null
          ? GestureDetector(
              child: CircleAvatar(
                backgroundImage: FileImage(widget.imgChosen),
              ),
              onTap: _chooseOptionToPick,
            )
          : IconButton(
              color: Colors.white,
              iconSize: 50,
              icon: Icon(Icons.account_circle_outlined),
              onPressed: _chooseOptionToPick,
            ),
    );
  }
}
