import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:launguagelearning/core/helper-function/api_service.dart';
import 'package:launguagelearning/core/utils/failure.dart';
import 'package:launguagelearning/data/models/auth_model.dart';
import 'package:launguagelearning/domain/repo/repo.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this.authRepository) : super(AuthInitial()) {
    _initializeAuth();
  }
  
  final Repository authRepository;

  Future<void> _initializeAuth() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('access_token');
    
    if (token != null && token.isNotEmpty) {
      // Set token in Dio headers
      GetIt.instance<DioClient>().setTokenIntoHeaderAfterLogin(token);
    }
  }

  Future<void> parentLogin({required String email, required String password}) async {
    emit(AuthLoading());

    final result = await authRepository.userLogin(email, password);

    result.fold(
      (Failure failure) => emit(AuthFailure(message: '${failure.message}')),
      (loginResponse) async {
        try {
          // Save tokens and user data
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('access_token', loginResponse.accessToken);
          await prefs.setString('refresh_token', loginResponse.refreshToken);
          await prefs.setString('user_id', loginResponse.user.id.toString());
          await prefs.setString('user_role', loginResponse.user.role);
          await prefs.setString('user_name', loginResponse.user.username);
          await prefs.setString('user_email', loginResponse.user.email);
          
          // Set token in Dio headers
          GetIt.instance<DioClient>().setTokenIntoHeaderAfterLogin(loginResponse.accessToken);
          
          emit(AuthSuccess(message: loginResponse.message));
        } catch (e) {
          emit(AuthFailure(message: 'Failed to save login data: $e'));
        }
      },
    );
  }

  Future<void> parentRegister({
    required String email,
    required String password,
    required String role,
    required String username
  }) async {
    emit(AuthRegisterLoading());

    final result = await authRepository.userregister(
      email,
      password,
      role,
      username
    );

    result.fold(
      (Failure failure) => emit(AuthRegisterFailure(message: '${failure.message}')),
      (loginResponse) async {
        try {
          // Save tokens and user data
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('access_token', loginResponse.accessToken);
          await prefs.setString('refresh_token', loginResponse.refreshToken);
          await prefs.setString('user_id', loginResponse.user.id.toString());
          await prefs.setString('user_role', loginResponse.user.role);
          await prefs.setString('user_name', loginResponse.user.username);
          await prefs.setString('user_email', loginResponse.user.email);
          
          // Set token in Dio headers
          GetIt.instance<DioClient>().setTokenIntoHeaderAfterLogin(loginResponse.accessToken);
          
          emit(AuthRegisterSuccess(message: loginResponse.message));
        } catch (e) {
          emit(AuthRegisterFailure(message: 'Failed to save registration data: $e'));
        }
      },
    );
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    GetIt.instance<DioClient>().addDioHeaders(); // Clear token from headers
    emit(AuthInitial());
  }
}
