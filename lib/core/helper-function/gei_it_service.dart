
import 'package:dio/dio.dart';

import 'package:get_it/get_it.dart';
import 'package:launguagelearning/core/helper-function/api_service.dart';
import 'package:launguagelearning/domain/repo/repo.dart';

final getIt = GetIt.instance;

void setupGetIt() {
  // Register DioClient as a singleton
  getIt.registerSingleton<DioClient>(DioClient());

  // DioClient
  getIt.registerLazySingleton<DioClient>(() => DioClient());

  // AuthRepository
  getIt.registerLazySingleton<Repository>(
    () => Repository(getIt<DioClient>()),
  );


  // // Register CharacterRepoImpl as a singleton
  // getIt.registerSingleton<GoldRepo>(
  //   GoldRepoImpl(goldRemoteDataSourceImpl: getIt<GoldRemoteDataSourceImpl>()),
  // );




}