import 'package:bloc/bloc.dart';
import 'package:launguagelearning/data/models/question_model.dart';
import 'package:launguagelearning/domain/repo/repo.dart';
import 'package:meta/meta.dart';

part 'question_state.dart';

class QuestionLangugeCubit extends Cubit<QuestionState> {
  QuestionLangugeCubit(this.repository) : super(QuestionInitial());

final Repository repository;

  Future<void> fetchquestionsBySectionId(int sectionId) async {
    emit(QuestionLoading());
    final result = await repository.questionsBySectionId(sectionId);
    result.fold(
      (failure) => emit(QuestionFailure(message: failure.message)),
      (questions) => emit(QuestionSuccess(questions: questions)),
    );
  }

}
