import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';

import '../../Models/routes.dart';

import './auth_form.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _auth = FirebaseAuth.instance;
  bool _isLoading = false;

  void _showError(BuildContext ctx, String msg) {
    Scaffold.of(ctx).hideCurrentSnackBar();
    if (msg != null)
      Scaffold.of(ctx).showSnackBar(
        SnackBar(
          content: Text(msg),
          backgroundColor: Theme.of(context).accentColor,
        ),
      );
  }

  Future<void> _submitAuthForm(
    String name,
    String username,
    String password,
    File image,
    bool isLogin,
    BuildContext ctx,
  ) async {
    setState(() {
      _isLoading = true;
    });

    AuthResult authResult;
    final email = '$username@chat.com';

    try {
      if (isLogin) {
        authResult = await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
      } else {
        authResult = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        final ref = FirebaseStorage.instance;
        var url;
        if (image != null) {
          List<String> l1 = image.path.split(".");
          final refImg = ref
              .ref()
              .child('user_images')
              .child(authResult.user.uid + '.${l1[l1.length - 1]}');
          await refImg.putFile(image).onComplete;
          url = await refImg.getDownloadURL();
        }
        print(url);
        await Firestore.instance
            .collection('users')
            .document(authResult.user.uid)
            .setData({
          'name': name,
          'username': username,
          'imgUrl': url,
        });
      }
      _showError(ctx, null);
      Navigator.of(context).popAndPushNamed(Routes.chat_screen);
    } on PlatformException catch (err) {
      var msg = "An error occurred. Please check your credentials!";

      if (err.message != null) {
        msg = err.message;
      }
      _showError(ctx, msg);
    } catch (err) {
      _showError(ctx, err);
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(25),
          ),
          margin: EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: AuthForm(_submitAuthForm, _isLoading),
            ),
          ),
        ),
      ),
    );
  }
}
