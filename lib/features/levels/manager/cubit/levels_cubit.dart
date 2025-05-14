import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:launguagelearning/core/utils/failure.dart';
import 'package:launguagelearning/data/models/levels_model.dart';
import 'package:launguagelearning/domain/repo/repo.dart';
import 'package:meta/meta.dart';

part 'levels_state.dart';

class LevelsCubit extends Cubit<LevelsState> {
  LevelsCubit(this.repository) : super(LevelsInitial());

  final Repository repository;
 Future<void> fetchLevels() async {
    emit(LevelsLoading());
    final result = await repository.allLevels();
    
    result.fold(
      (failure) => emit(LevelsFailure(message: failure.message)),
      (List<Level> response  ) => emit(LevelsSuccess(levels: response)),
    );
  }

}
