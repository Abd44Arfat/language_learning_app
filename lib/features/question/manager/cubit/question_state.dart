part of 'question_cubit.dart';

@immutable
sealed class QuestionState {}

final class QuestionInitial extends QuestionState {}
final class QuestionLoading extends QuestionState {}
final class QuestionSuccess extends QuestionState {
final List<QuestionModel>questions;

  QuestionSuccess({required this.questions});

}
final class QuestionFailure extends QuestionState {
final String message;

  QuestionFailure({required this.message});

}
