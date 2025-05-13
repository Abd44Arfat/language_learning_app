
import 'package:flutter/material.dart';
import 'package:launguagelearning/features/auth/views/signIn_screen.dart';
import 'package:launguagelearning/features/auth/views/signup_screen.dart';
import 'package:launguagelearning/features/auth/views/splash_screen.dart';
import 'package:launguagelearning/features/home/home_screen.dart';
import 'package:launguagelearning/features/question/audioQuestion/audio_Question.dart';
import 'package:launguagelearning/features/question/imageQuestion/imageQuestion.dart';
import 'package:launguagelearning/features/question/reading/questionscreen.dart';
import 'package:launguagelearning/features/sections/sections_Screen.dart';
import 'package:launguagelearning/features/vocabulary/vacbulary_screen.dart';

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

  case VocabularyScreen.routeName:
      return MaterialPageRoute(builder: (context) =>  VocabularyScreen());


  case ImageQuestionScreen.routeName:
      return MaterialPageRoute(builder: (context) =>  ImageQuestionScreen());

  case AudioQuestionScreen.routeName:
      return MaterialPageRoute(builder: (context) =>  AudioQuestionScreen());


  case SectionsScreen.routeName:
      return MaterialPageRoute(builder: (context) =>  SectionsScreen());

    default:
      return MaterialPageRoute(builder: (context) => const Scaffold());
  }
}