import 'package:flutter/material.dart';
import 'main.dart';
import 'Login/LoginScreen.dart';
import 'Login/LandingPage.dart';

class RouteGenerator{
  static Route<dynamic> generateRoute(RouteSettings settings){
    final args = settings.arguments;

    switch(settings.name){
      case '/':
        return MaterialPageRoute(builder: (context)=> LandingPage());
      case '/login':
        return MaterialPageRoute(builder: (context)=> LoginScreen());
      case '/home':
        return MaterialPageRoute(builder: (context)=> HomePage());
      
      default: // display error route
        return _errorRoute();
    }
  }
}


Route<dynamic> _errorRoute(){
  return MaterialPageRoute(builder: (context)=> Scaffold( body: Center(child: Text('ERROR ROUTE!'),),));
}