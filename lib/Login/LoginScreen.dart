import 'package:flutter/material.dart';
import 'validators.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final Color priColor = Colors.green ;

  void _loginAction() {
    // route to home page?
    Navigator.pushReplacementNamed(context, '/home');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("Carbon Wallet"),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Form(
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 20),
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Icon(
                  Icons.local_mall,
                  size: 80,
                ),
              ),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                    focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        borderSide: BorderSide(color: priColor)),
                    labelStyle: TextStyle(color: priColor),
                    icon: Icon(
                      Icons.email,
                      color: priColor,
                    ),
                    labelText: 'Email',
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        borderSide: BorderSide(color: priColor))),
                autovalidate: true,
                autocorrect: false,
                validator: (email) {
                  return !Validators.isValidEmail(email) ? 'Invalid Email' : null;
                },
              ),
              SizedBox(
                height: 5,
              ),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                    focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        borderSide: BorderSide(color: priColor)),
                    labelStyle: TextStyle(color: priColor),
                    icon: Icon(
                      Icons.vpn_key,
                      color: priColor,
                    ),
                    labelText: 'Password',
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        borderSide: BorderSide(color: priColor))),
                obscureText: true,
                autovalidate: true,
                autocorrect: false,
                validator: (password) {
                  return !Validators.isValidPassword(password)
                      ? 'Invalid Password'
                      : null;
                },
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0)),
                      onPressed: _loginAction,
                      child: Text('Login'),
                    ),
                    FlatButton(
                      child: Text('Create an Account'),
                      onPressed: () {
                        // TODO: USER SIGNUP
                      },
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
