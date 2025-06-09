import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:launguagelearning/core/helper-function/gei_it_service.dart';
import 'package:launguagelearning/core/helper-function/on_generate_route.dart';
import 'package:launguagelearning/features/auth/manager/cubit/auth_cubit.dart';
import 'package:launguagelearning/features/auth/views/signIn_screen.dart';
import 'package:launguagelearning/features/auth/views/signup_screen.dart';
import 'package:launguagelearning/features/auth/views/splash_screen.dart';
import 'package:launguagelearning/features/auth/views/splash_screen2.dart';
import 'package:launguagelearning/features/levels/levels_screen.dart';
import 'package:launguagelearning/features/question/audioQuestion/audio_Question.dart';
import 'package:launguagelearning/features/question/imageQuestion/imageQuestion.dart';
import 'package:launguagelearning/features/question/reading/questionscreen.dart';
import 'package:launguagelearning/features/sections/sections_Screen.dart';
import 'package:launguagelearning/features/vocabulary/vacbulary_screen.dart';

void main() {
  setupGetIt();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(getIt()),
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            initialRoute: SplashScreen2.routeName,
            onGenerateRoute: onGenerateRoute,
          );
        },
      ),
    );
  }
}

