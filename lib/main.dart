import 'package:flutter/material.dart';
import 'package:launguagelearning/core/helper-function/on_generate_route.dart';
import 'package:launguagelearning/features/auth/views/splash_screen.dart';
import 'package:launguagelearning/features/question/questionscreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
     
    initialRoute: QuestionScreen.routeName,
    onGenerateRoute: onGenerateRoute,
    );
  }
}
