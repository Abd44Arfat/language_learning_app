import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:launguagelearning/features/question/cubit/tracker_cubit.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class QuestionsTracker extends StatelessWidget {
  const QuestionsTracker({super.key, required this.totalQ});
  final int totalQ;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ScoreTrackerCubit, ScoreTrackerState>(
      builder: (context, state) {
        double progressPercent = totalQ > 0
            ? (state.currentProgress / totalQ).clamp(0.0, 1.0)
            : 0.0;
        return LinearPercentIndicator(
          animateFromLastPercent: true,
          barRadius: const Radius.circular(13),
          animationDuration: 1000,
          animation: true,
          width: MediaQuery.of(context).size.width,
          lineHeight: 30,
          percent: progressPercent,
          progressColor: Colors.lightBlueAccent,
          backgroundColor: Colors.white,
        );
      },
    );
  }
}