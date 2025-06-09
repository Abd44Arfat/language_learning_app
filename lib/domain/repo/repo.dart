import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:launguagelearning/core/helper-function/api_service.dart';
import 'package:launguagelearning/core/utils/constants.dart';
import 'package:launguagelearning/core/utils/failure.dart';
import 'package:launguagelearning/data/models/auth_model.dart';
import 'package:launguagelearning/data/models/levels_model.dart';
import 'package:launguagelearning/data/models/question_model.dart';
import 'package:launguagelearning/data/models/sections_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Repository {
  final DioClient api;

  Repository(this.api);

  Future<Either<Failure, LoginResponse>> userLogin(
  String email,
  String password,
) async {
  try {
    final response = await api.post(
      ApiUrls.login,
      data: {'email': email, 'password': password},
    );

    final loginResponse = LoginResponse.fromJson(response.data);

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('access_token', loginResponse.accessToken);

    return Right(loginResponse);
  } on DioException catch (e) {
    return Left(Failure(e.toString()));
  } catch (e) {
    return Left(Failure(e.toString()));
  }
}

Future<Either<Failure, RegisterResponse>> userregister(
  String email,
  String password,
  String role,
  String username,
) async {
  try {
    final response = await api.post(
      ApiUrls.register,
      data: {
        'email': email,
        'password': password,
        'role': role,
        'username': username
      },
    );

    final loginResponse = RegisterResponse.fromJson(response.data);

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('access_token', loginResponse.accessToken);

    return Right(loginResponse);
  } on DioException catch (e) {
    return Left(Failure(e.toString()));
  } catch (e) {
    return Left(Failure(e.toString()));
  }
}






  Future<Either<Failure, List<Level>>> allLevels() async {
  try {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('access_token');

    if (token == null) {
      return Left(Failure('Access token not found'));
    }

    final response = await api.get(
      ApiUrls.getAllLevels, // make sure this is the correct endpoint
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
        },
      ),
    );
    final data = List<Map<String, dynamic>>.from(response.data['data']);

          List<Level> levels = data.map((trainerJson) => Level.fromJson(trainerJson)).toList();


    return Right(levels);
  } on DioException catch (e) {
    return Left(Failure(e.toString()));
  } catch (e) {
    return Left(Failure(e.toString()));
  }
}


Future<Either<Failure, List<Section>>> sectionsById(int levelId) async {
  try {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('access_token');

    if (token == null) {
      return Left(Failure('Access token not found'));
    }

    final response = await api.get(
      ApiUrls.sectionById, // e.g., 'api/section'
      queryParameters: {
        'level_id': levelId,
      },
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
        },
      ),
    );

    final List<dynamic> rawData = response.data['data'];
    final List<Section> sections = rawData
        .map((json) => Section.fromJson(json as Map<String, dynamic>))
        .toList();

    return Right(sections);
  } on DioException catch (e) {
    return Left(Failure(e.message ?? 'DioException occurred'));
  } catch (e) {
    return Left(Failure(e.toString()));
  }
}



Future<Either<Failure, List<QuestionModel>>> questionsBySectionId(int section_id) async {
  try {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('access_token');

    if (token == null) {
      return Left(Failure('Access token not found'));
    }

    final response = await api.get(
      ApiUrls.allQuestion, // e.g., 'api/section'
      queryParameters: {
        'section_id': section_id,
      },
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
        },
      ),
    );

    final List<dynamic> rawData = response.data['data'];
    final List<QuestionModel> sections = rawData
        .map((json) => QuestionModel.fromJson(json as Map<String, dynamic>))
        .toList();

    return Right(sections);
  } on DioException catch (e) {
    return Left(Failure(e.message ?? 'DioException occurred'));
  } catch (e) {
    return Left(Failure(e.toString()));
  }
}
  
  }