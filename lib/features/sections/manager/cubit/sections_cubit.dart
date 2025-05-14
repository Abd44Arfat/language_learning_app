import 'package:bloc/bloc.dart';
import 'package:launguagelearning/data/models/sections_model.dart';
import 'package:launguagelearning/domain/repo/repo.dart';
import 'package:meta/meta.dart';

part 'sections_state.dart';

class SectionsCubit extends Cubit<SectionsState> {
  SectionsCubit(this.repository) : super(SectionsInitial());





  final Repository repository;

  Future<void> fetchSectionsByLevelId(int levelId) async {
    emit(SectionsLoading());
    final result = await repository.sectionsById(levelId);
    result.fold(
      (failure) => emit(SectionsFailure(message: failure.message)),
      (sections) => emit(SectionsSuccess(sections: sections)),
    );
  }
}


