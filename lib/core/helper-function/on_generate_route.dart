
import 'package:flutter/material.dart';
import 'package:launguagelearning/features/auth/views/signIn_screen.dart';
import 'package:launguagelearning/features/auth/views/signup_screen.dart';
import 'package:launguagelearning/features/auth/views/splash_screen.dart';
import 'package:launguagelearning/features/home/home_screen.dart';
import 'package:launguagelearning/features/question/questionscreen.dart';

Route<dynamic> onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case SplashScreen.routeName:
      return MaterialPageRoute(builder: (context) => const SplashScreen());

    case SignIn.routeName:
      return MaterialPageRoute(builder: (context) =>  SignIn());

    case Signup.routeName:
      return MaterialPageRoute(builder: (context) =>  Signup());

  case Homescreen.routeName:
      return MaterialPageRoute(builder: (context) =>  Homescreen());

  case QuestionScreen.routeName:
      return MaterialPageRoute(builder: (context) =>  QuestionScreen());


    default:
      return MaterialPageRoute(builder: (context) => const Scaffold());
  }
}