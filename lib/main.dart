import 'package:flutter/material.dart';
import 'package:launguagelearning/core/helper-function/on_generate_route.dart';
import 'package:launguagelearning/features/auth/views/signIn_screen.dart';
import 'package:launguagelearning/features/auth/views/splash_screen.dart';
import 'package:launguagelearning/features/question/audioQuestion/audio_Question.dart';
import 'package:launguagelearning/features/question/imageQuestion/imageQuestion.dart';
import 'package:launguagelearning/features/question/reading/questionscreen.dart';
import 'package:launguagelearning/features/sections/sections_Screen.dart';
import 'package:launguagelearning/features/vocabulary/vacbulary_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
     
    initialRoute: SignIn.routeName,
    onGenerateRoute: onGenerateRoute,
    );
  }
}
