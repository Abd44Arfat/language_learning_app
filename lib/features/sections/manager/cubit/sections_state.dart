part of 'sections_cubit.dart';

@immutable
sealed class SectionsState {}

final class SectionsInitial extends SectionsState {}
final class SectionsLoading extends SectionsState {}
final class SectionsSuccess extends SectionsState {

  final List<Section> sections;
  SectionsSuccess({required this.sections});
}
final class SectionsFailure extends SectionsState {

  final String message;

  SectionsFailure({required this.message});
}
