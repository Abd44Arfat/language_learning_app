part of 'levels_cubit.dart';

@immutable
sealed class LevelsState {}

final class LevelsInitial extends LevelsState {}
final class LevelsLoading extends LevelsState {}
final class LevelsSuccess extends LevelsState {

final List <Level>levels;

  LevelsSuccess({required this.levels});

}
final class LevelsFailure extends LevelsState {
final String message;

  LevelsFailure({required this.message});

}
