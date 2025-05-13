import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:launguagelearning/core/utils/styles.dart';
import 'package:launguagelearning/features/home/home_screen.dart';
import 'package:launguagelearning/features/question/cubit/tracker_cubit.dart';
import 'package:launguagelearning/features/question/reading/question_tracker.dart';

class ImageQuestionScreen extends StatelessWidget {
  ImageQuestionScreen({super.key});
  static const String routeName = '/imagequestion';

  final List<Question> questions = [
    Question(
      questionText: 'Choose the Correct Answer?',
      optionImages: [
        'assets/images/drink.png',
        'assets/images/eat.png',
        'assets/images/run.png',
        'assets/images/sleep.png',
      ],
      correctAnswer: 'eat',
    ),
    Question(
      questionText: 'Choose the Correct Answer?',
      optionImages: [
        'assets/images/apple.png',
        'assets/images/banana.png',
        'assets/images/orange.png',
        'assets/images/grape.png',
      ],
      correctAnswer: 'orange',
    ),
    // Add more questions as needed
  ];

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
            
                const SizedBox(height: 10),
                Text(
                  question.questionText,
                  style: TextStyles.font30WhiteBold,
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: GridView.builder(
                    itemCount: question.optionImages.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                      childAspectRatio: 1, // Adjusted for image-based options
                    ),
                    itemBuilder: (context, index) {
                      final optionImage = question.optionImages[index];
                      final optionIdentifier = question.optionImages[index].split('/').last.split('.').first;
                      return BlocBuilder<ScoreTrackerCubit, ScoreTrackerState>(
                        builder: (context, scoreState) {
                          final isCorrect = optionIdentifier == question.correctAnswer;
                          final isAnswerSelected = questionState.answerSelected;
                          final isSelected = scoreState.selectedAnswer == index;

                          Color backgroundColor = Colors.transparent;
                          if (isAnswerSelected) {
                            if (isCorrect) {
                              backgroundColor = Colors.green; // Correct answer in green
                            } else {
                              backgroundColor = Colors.red.withOpacity(0.7); // Incorrect answer in red
                            }
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
                              imagePath: optionImage,
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
                        questionState.currentIndex < questions.length - 1 ? 'التالي' : 'إنهاء',
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
    required this.imagePath,
    required this.isSelected,
    required this.backgroundColor,
  });

  final String imagePath;
  final bool isSelected;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor,
          border: Border.all(color: Colors.white, width: 2),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Image.asset(
            imagePath,
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) => const Icon(
              Icons.broken_image,
              size: 50,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

// Model
class Question {
  final String questionText;
  final List<String> optionImages;
  final String correctAnswer;

  Question({
    required this.questionText,
    required this.optionImages,
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