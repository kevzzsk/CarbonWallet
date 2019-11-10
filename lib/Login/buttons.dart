import 'package:flutter/material.dart';



class LoginButton extends StatelessWidget {

  final VoidCallback _onPressed;

  LoginButton({Key key, VoidCallback onPressed})
      : _onPressed = onPressed,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0)
      ),
      onPressed: _onPressed,
      child: Text('Login'),
    );
  }
}


class CreateAccountButton extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      child: Text('Create an Account'),
      onPressed: (){
        // TODO: USER SIGNUP
      },
    );
  }
}