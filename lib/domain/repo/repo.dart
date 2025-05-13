import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:launguagelearning/core/helper-function/api_service.dart';
import 'package:launguagelearning/core/utils/constants.dart';
import 'package:launguagelearning/core/utils/failure.dart';
import 'package:launguagelearning/data/models/auth_model.dart';

class Repository {
  final DioClient api;

  Repository(this.api);

  Future<Either<Failure, LoginResponse>> userLogin(
    String email,
    String password,
  ) async {
    try {
      final response = await api.post(
       ApiUrls.getAllCurrencies,
        data: {'email': email, 'password': password},
      );
      // final prefs = await SharedPreferences.getInstance();
      return Right(LoginResponse.fromJson(response.data));
    } on DioException catch (e) {
      return Left(Failure(e.toString()));
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }}