import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:launguagelearning/core/utils/styles.dart';
import 'package:launguagelearning/features/home/home_screen.dart';
import 'package:launguagelearning/features/question/cubit/tracker_cubit.dart';
import 'package:launguagelearning/features/question/reading/question_tracker.dart';

class AudioQuestionScreen extends StatefulWidget {
  AudioQuestionScreen({super.key});
  static const String routeName = '/audioQuestion';

  final List<Question> questions = [
    Question(
      questionText: 'Listen and choose the correct word.',
      audioPath: 'audios/good-morning.mp3', // Ensure this file exists in your assets
      options: ['Eat', 'Good morning', 'Run', 'Sleep'],
      correctAnswer: 'Good morning',
    ),
    Question(
      questionText: 'Listen and choose the correct word.',
      audioPath: 'audios/good-morning.mp3', // Ensure this file exists in your assets
      options: ['Apple', 'Banana', 'Orange', 'Grape'],
      correctAnswer: 'Orange',
    ),
    // Add more questions as needed
  ];

  @override
  _AudioQuestionScreenState createState() => _AudioQuestionScreenState();
}

class _AudioQuestionScreenState extends State<AudioQuestionScreen> {
  final AudioPlayer audioPlayer = AudioPlayer();

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ScoreTrackerCubit(totalQuestions: widget.questions.length)),
        BlocProvider(create: (_) => QuestionCubit(totalQuestions: widget.questions.length)),
      ],
      child: Scaffold(
        backgroundColor: Colors.blueAccent,
        appBar: AppBar(title: const Text('Audio Question')),
        body: BlocBuilder<QuestionCubit, QuestionState>(
          builder: (context, questionState) {
            if (questionState.currentIndex >= widget.questions.length) {
              return Center(
                child: QuizCompletedDialog(
                  totalQuestions: widget.questions.length,
                ),
              );
            }

            final question = widget.questions[questionState.currentIndex];

            return Column(
              children: [
                const SizedBox(height: 10),
                QuestionsTracker(totalQ: widget.questions.length),
                const SizedBox(height: 10),
                Text(
                  question.questionText,
                  style: TextStyles.font30WhiteBold,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    await audioPlayer.play(AssetSource(question.audioPath));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.blueAccent,
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  ),
                  child: const Text('Play Audio'),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: GridView.builder(
                    itemCount: question.options.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                      childAspectRatio: 1.5, // Adjusted for text-based options
                    ),
                    itemBuilder: (context, index) {
                      final option = question.options[index];
                      return BlocBuilder<ScoreTrackerCubit, ScoreTrackerState>(
                        builder: (context, scoreState) {
                          final isCorrect = option == question.correctAnswer;
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
                              text: option,
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
                        questionState.currentIndex < widget.questions.length - 1 ? 'Next' : 'Finish',
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
    required this.text,
    required this.isSelected,
    required this.backgroundColor,
  });

  final String text;
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
          child: Text(
            text,
            style: TextStyles.font30WhiteBold,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}

// Updated Question Model
class Question {
  final String questionText;
  final String audioPath;
  final List<String> options;
  final String correctAnswer;

  Question({
    required this.questionText,
    required this.audioPath,
    required this.options,
    required this.correctAnswer,
  });
}

// Question State and Cubit (unchanged)
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