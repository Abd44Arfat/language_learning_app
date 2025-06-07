import 'package:bloc/bloc.dart';
import 'package:launguagelearning/core/utils/failure.dart';
import 'package:launguagelearning/data/models/auth_model.dart';
import 'package:launguagelearning/domain/repo/repo.dart';
import 'package:meta/meta.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this.authRepository) : super(AuthInitial());
  final Repository authRepository;


    Future<void> parentLogin({required String email, required String password}) async {
    emit(AuthLoading());

    final result = await authRepository.userLogin(email, password);

    result.fold(
      (Failure failure) => emit(AuthFailure(message: '${failure.message}')),
      ( loginResponse) => emit(AuthSuccess( message: 'Login Success')),
    );
  }

  Future<void> parentRegister({required String email, required String password,required String role,required String name}) async {
    emit(AuthRegisterLoading());

    final result = await authRepository.userregister(email, password,role,name);

    result.fold(
      (Failure failure) => emit(AuthRegisterFailure(message: '${failure.message}')),
      ( loginResponse) => emit(AuthRegisterSuccess( message: 'Login Success')),
    );
  }

}
