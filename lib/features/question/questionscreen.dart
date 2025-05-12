import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:launguagelearning/core/utils/styles.dart';
import 'package:launguagelearning/features/question/cubit/tracker_cubit.dart';
import 'package:launguagelearning/features/question/question_tracker.dart';

class QuestionScreen extends StatelessWidget {
  const QuestionScreen({super.key});
  static const String routeName = '/question';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ScoreTrackerCubit(totalQuestions: 6),
      child: Scaffold(
        backgroundColor: Colors.blueAccent,
        appBar: AppBar(title: const Text('Question')),
        body: Column(
          children: [
            const SizedBox(height: 10),
            QuestionsTracker(totalQ: 6), // Aligned with totalQuestions
            const SizedBox(height: 10),
            Image.asset(
              "assets/images/image 119.png", // Renamed to avoid spaces
              height: 250,
            ),
            Text("Choose the Correct Answer ?",style: TextStyles.font30WhiteBold,),
                        const SizedBox(height: 10),

            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Two items per row
                  crossAxisSpacing: 8, // Spacing between columns
                  mainAxisSpacing: 8, // Spacing between rows
                  childAspectRatio: 2, // Adjust width-to-height ratio of items
                ),
                itemCount: 4, // One item per question
                itemBuilder: (context, index) {
                  return QuestionItem(
                    title: 'Drink', // You can make this dynamic if needed
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class QuestionItem extends StatelessWidget {
  const QuestionItem({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border.all(
            color: Colors.white, // Black border
            width: 2,
          ),
          borderRadius: BorderRadius.circular(12), // Rounded corners
        ),
        child: Center(
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}