import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:launguagelearning/core/helper-function/gei_it_service.dart';
import 'package:launguagelearning/features/auth/views/signIn_screen.dart';
import 'package:launguagelearning/features/auth/views/signup_screen.dart';
import 'package:launguagelearning/features/auth/views/splash_screen.dart';
import 'package:launguagelearning/features/home/home_screen.dart';
import 'package:launguagelearning/features/levels/levels_screen.dart';
import 'package:launguagelearning/features/levels/manager/cubit/levels_cubit.dart';
import 'package:launguagelearning/features/question/audioQuestion/audio_Question.dart';
import 'package:launguagelearning/features/question/imageQuestion/imageQuestion.dart';
import 'package:launguagelearning/features/question/manager/cubit/question_cubit.dart';
import 'package:launguagelearning/features/question/reading/questionscreen.dart';
import 'package:launguagelearning/features/sections/manager/cubit/sections_cubit.dart';
import 'package:launguagelearning/features/sections/sections_Screen.dart';
import 'package:launguagelearning/features/vocabulary/vacbulary_screen.dart';

Route<dynamic> onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case SplashScreen.routeName:
      return MaterialPageRoute(builder: (context) => const SplashScreen());

    case SignIn.routeName:
      return MaterialPageRoute(builder: (context) => SignIn());

    case Signup.routeName:
      return MaterialPageRoute(builder: (context) => Signup());
    case Homescreen.routeName:
      final args = settings.arguments as Map<String, dynamic>;
      return MaterialPageRoute(
        builder:
            (_) => BlocProvider(
              create: (context) => QuestionLangugeCubit(getIt()),
              child: Homescreen(
                sectionName: args['sectionName'],
                sectionImage: args['sectionImage'],
                 sectionId: args['section_id'],
              ),
            ),
      );
    case QuestionScreen.routeName:
      final args = settings.arguments as Map<String, dynamic>;
      return MaterialPageRoute(
        builder: (context) => QuestionScreen(questions: args['questions']),
      );

    case VocabularyScreen.routeName:
      return MaterialPageRoute(builder: (context) => VocabularyScreen());

    case ImageQuestionScreen.routeName:
      final args = settings.arguments as Map<String, dynamic>;
      return MaterialPageRoute(
        builder: (context) => ImageQuestionScreen(questions: args['questions']),
      );

    case AudioQuestionScreen.routeName:
      final args = settings.arguments as Map<String, dynamic>;
      return MaterialPageRoute(
        builder: (context) => AudioQuestionScreen(questions: args['questions']),
      );

    case SectionsScreen.routeName:
      final levelId = settings.arguments as int;
      return MaterialPageRoute(
        builder:
            (context) => BlocProvider(
              create: (context) => SectionsCubit(getIt()),
              child: SectionsScreen(levelId: levelId),
            ),
      );
    case LevelsScreen.routeName:
      return MaterialPageRoute(
        builder:
            (context) => BlocProvider(
              create: (context) => LevelsCubit(getIt()),
              child: LevelsScreen(),
            ),
      );

    default:
      return MaterialPageRoute(builder: (context) => const Scaffold());
  }
}
