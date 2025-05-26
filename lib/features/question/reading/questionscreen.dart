import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:launguagelearning/core/utils/constants.dart';
import 'package:launguagelearning/core/utils/styles.dart';
import 'package:launguagelearning/data/models/question_model.dart';
import 'package:launguagelearning/features/home/home_screen.dart';
import 'package:launguagelearning/features/question/cubit/tracker_cubit.dart';
import 'package:launguagelearning/features/question/reading/question_tracker.dart';

class QuestionScreen extends StatelessWidget {
  QuestionScreen({super.key, required this.questions});
  static const String routeName = '/question';

  final List<QuestionModel> questions;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ScoreTrackerCubit(totalQuestions: questions.length)),
        BlocProvider(create: (_) => QuestionCubit(totalQuestions: questions.length)),
      ],
      child: Scaffold(
        backgroundColor: Colors.blueAccent,
        appBar: AppBar(title: const Text('Question')),
        body: BlocBuilder<QuestionCubit, QuestionState>(
          builder: (context, questionState) {
            if (questionState.currentIndex >= questions.length) {
              return Center(
                child: QuizCompletedDialog(
                  totalQuestions: questions.length,
                ),
              );
            }

            final question = questions[questionState.currentIndex];

            return Column(
              children: [
                const SizedBox(height: 10),
                QuestionsTracker(totalQ: questions.length),
                const SizedBox(height: 10),
                // TODO: Add image if available in question data
                const SizedBox(height: 10),
                Text(
                  question.questionContent,
                  style: TextStyles.font30WhiteBold,
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: GridView.builder(
                    itemCount: question.choices.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                      childAspectRatio: 2,
                    ),
                    itemBuilder: (context, index) {
                      final choice = question.choices[index];
                      return BlocBuilder<ScoreTrackerCubit, ScoreTrackerState>(
                        builder: (context, scoreState) {
                          final isCorrect = choice.isCorrect;
                          final isAnswerSelected = questionState.answerSelected;
                          final isSelected = scoreState.selectedAnswer == index;

                          Color backgroundColor = Colors.transparent;
                          if (isAnswerSelected) {
                            backgroundColor = isCorrect ? Colors.green : Colors.red.withOpacity(0.7);
                          }

                          return GestureDetector(
                            onTap: () {
                              if (!questionState.answerSelected) {
                                context.read<QuestionCubit>().selectAnswer();
                                context.read<ScoreTrackerCubit>().selectAnswer(index, isCorrect);
                                context.read<ScoreTrackerCubit>().incrementProgress();
                                if (isCorrect) {
                                  context.read<ScoreTrackerCubit>().incrementScore();
                                }
                              }
                            },
                            child: QuestionItem(
                              title: choice.content,
                              isSelected: isSelected,
                              backgroundColor: backgroundColor,
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
                if (questionState.answerSelected)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: ElevatedButton(
                      onPressed: () {
                        context.read<QuestionCubit>().nextQuestion();
                        context.read<ScoreTrackerCubit>().resetSelectedAnswer();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.blueAccent,
                        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                        textStyle: const TextStyle(fontSize: 18),
                      ),
                      child: Text(
                        questionState.currentIndex < questions.length - 1 ? 'Next' : 'Finish',
                      ),
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class QuizCompletedDialog extends StatelessWidget {
  final int totalQuestions;

  const QuizCompletedDialog({super.key, required this.totalQuestions});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Quiz Completed'),
      content: BlocBuilder<ScoreTrackerCubit, ScoreTrackerState>(
        builder: (context, scoreState) {
          return Text('You scored ${scoreState.score} out of $totalQuestions');
        },
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pushNamed(context, Homescreen.routeName),
          child: const Text('OK'),
        ),
      ],
    );
  }
}
class QuestionItem extends StatelessWidget {
  const QuestionItem({
    super.key,
    required this.title,
    required this.isSelected,
    required this.backgroundColor,
  });

  final String title;
  final bool isSelected;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            color: backgroundColor,
            border: Border.all(color: Colors.white, width: 2),
            borderRadius: BorderRadius.circular(12),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              'http://127.0.0.1:5000/$title',
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
              errorBuilder: (context, error, stackTrace) => const Icon(Icons.error),
            ),
          ),
        ),

        // ✅ Overlay for selection effect
        if (backgroundColor != Colors.transparent)
          Container(
            decoration: BoxDecoration(
              color: backgroundColor.withOpacity(0.5),
              borderRadius: BorderRadius.circular(12),
            ),
          ),

        // ✅ Show the icon (correct or wrong)
        if (backgroundColor != Colors.transparent)
          Positioned(
            top: 8,
            right: 8,
            child: Icon(
              backgroundColor == Colors.green ? Icons.check_circle : Icons.cancel,
              color: backgroundColor == Colors.green ? Colors.greenAccent : Colors.redAccent,
              size: 32,
            ),
          ),
      ],
    );
  }
}



// Model
class Question {
  final String imagePath;
  final String questionText;
  final List<String> options;
  final String correctAnswer;

  Question({
    required this.imagePath,
    required this.questionText,
    required this.options,
    required this.correctAnswer,
  });
}

// Question State and Cubit
class QuestionState {
  final int currentIndex;
  final bool answerSelected;

  QuestionState({
    required this.currentIndex,
    required this.answerSelected,
  });

  QuestionState copyWith({
    int? currentIndex,
    bool? answerSelected,
  }) {
    return QuestionState(
      currentIndex: currentIndex ?? this.currentIndex,
      answerSelected: answerSelected ?? this.answerSelected,
    );
  }
}

class QuestionCubit extends Cubit<QuestionState> {
  final int totalQuestions;

  QuestionCubit({required this.totalQuestions})
      : super(QuestionState(currentIndex: 0, answerSelected: false));

  void selectAnswer() {
    emit(state.copyWith(answerSelected: true));
  }

  void nextQuestion() {
    emit(state.copyWith(
      currentIndex: state.currentIndex + 1,
      answerSelected: false,
    ));
  }
}
