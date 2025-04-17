
import 'package:flutter/material.dart';
import 'package:launguagelearning/features/auth/views/signIn_screen.dart';
import 'package:launguagelearning/features/auth/views/splash_screen.dart';

Route<dynamic> onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case SplashScreen.routeName:
      return MaterialPageRoute(builder: (context) => const SplashScreen());

    case SignIn.routeName:
      return MaterialPageRoute(builder: (context) =>  SignIn());

    default:
      return MaterialPageRoute(builder: (context) => const Scaffold());
  }
}