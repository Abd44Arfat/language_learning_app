import 'package:flutter_bloc/flutter_bloc.dart';

class ScoreTrackerState {
  final int totalQuestions;
  final int score;
  final int currentProgress;
  final int? selectedAnswer;
  final bool? isCorrect;

  ScoreTrackerState({
    required this.totalQuestions,
    this.score = 0,
    this.currentProgress = 0,
    this.selectedAnswer,
    this.isCorrect,
  });

  ScoreTrackerState copyWith({
    int? totalQuestions,
    int? score,
    int? currentProgress,
    int? selectedAnswer,
    bool? isCorrect,
  }) {
    return ScoreTrackerState(
      totalQuestions: totalQuestions ?? this.totalQuestions,
      score: score ?? this.score,
      currentProgress: currentProgress ?? this.currentProgress,
      selectedAnswer: selectedAnswer,
      isCorrect: isCorrect,
    );
  }
}

class ScoreTrackerCubit extends Cubit<ScoreTrackerState> {
  ScoreTrackerCubit({required int totalQuestions})
      : super(ScoreTrackerState(totalQuestions: totalQuestions));

  void incrementScore() {
    emit(state.copyWith(score: state.score + 1));
  }

  void incrementProgress() {
    if (state.currentProgress < state.totalQuestions) {
      emit(state.copyWith(currentProgress: state.currentProgress + 1));
    }
  }

  void selectAnswer(int answerIndex, bool isCorrect) {
    emit(state.copyWith(selectedAnswer: answerIndex, isCorrect: isCorrect));
  }

  void resetSelectedAnswer() {
    emit(state.copyWith(selectedAnswer: null, isCorrect: null));
  }
}