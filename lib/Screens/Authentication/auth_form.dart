import 'dart:io';

import 'package:flutter/material.dart';
import 'package:string_validator/string_validator.dart';

import '../Profile/profile_image.dart';

class AuthForm extends StatefulWidget {
  final void Function(
    String,
    String,
    String,
    File,
    bool,
    BuildContext,
  ) submitForm;
  final bool isLoading;

  AuthForm(this.submitForm, this.isLoading);

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();

  var _isLogin = true;

  String _name = '';
  String _userName = '';
  String _userPassword = '';
  File _userImg;

  void _pickedImg(File image) {
    _userImg = image;
  }

  void _trySubmit() {
    final isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();

    if (isValid) {
      _formKey.currentState.save();
      widget.submitForm(
        _name.trim(),
        _userName.trim(),
        _userPassword.trim(),
        _userImg,
        _isLogin,
        context,
      );
    }
  }

  String _validateName(String val) {
    if (val.isEmpty) {
      return "This field is required.";
    } else if (val.length <= 4) {
      return "Name must be atleast 5 characters long.";
    } else {
      List<String> nameList = val.split(" ");
      String msg;
      nameList.forEach((item) {
        if (!isAlpha(item)) msg = "Name can contain letters only.";
      });
      return msg;
    }
  }

  String _validatePassword(String val) {
    if (val.isEmpty) {
      return "This field is required.";
    } else if (val.length <= 7) {
      return "Password must be atleast 8 characters long.";
    }
    return null;
  }

  String _validatUsername(String val) {
    if (val.isEmpty) {
      return "This field is required.";
    } else if (val.length <= 4) {
      return "Username must be atleast 5 characters long.";
    } else if (!isAlphanumeric(val)) {
      return "Username can contain letters and numbers only.";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          if (!_isLogin) ...[
            ProfileImage(null, _pickedImg),
            TextFormField(
              key: ValueKey('name'),
              textCapitalization: TextCapitalization.words,
              validator: (val) => _validateName(val),
              decoration: InputDecoration(labelText: "Name"),
              onSaved: (val) {
                _name = val;
              },
            ),
          ],
          TextFormField(
            key: ValueKey('username'),
            validator: (val) => _validatUsername(val),
            decoration: InputDecoration(labelText: "Username"),
            onSaved: (val) {
              _userName = val;
            },
          ),
          TextFormField(
            key: ValueKey('password'),
            validator: (val) => _validatePassword(val),
            obscureText: true,
            decoration: InputDecoration(labelText: "Password"),
            onSaved: (val) {
              _userPassword = val;
            },
          ),
          SizedBox(height: 10),
          if (widget.isLoading)
            Container(
              height: 95,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          if (!widget.isLoading) ...[
            RaisedButton(
              child: Text(_isLogin ? "Login" : "Create"),
              onPressed: _trySubmit,
            ),
            FlatButton(
              textColor: Theme.of(context).primaryColor,
              child: Text(
                _isLogin ? "Create new account" : "Already have an account",
              ),
              onPressed: () {
                setState(() {
                  _isLogin = !_isLogin;
                });
              },
            )
          ]
        ],
      ),
    );
  }
}
