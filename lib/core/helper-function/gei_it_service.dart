
import 'package:dio/dio.dart';

import 'package:get_it/get_it.dart';
import 'package:launguagelearning/core/helper-function/api_service.dart';

final getIt = GetIt.instance;

void setupGetIt() {
  // Register DioClient as a singleton
  getIt.registerSingleton<DioClient>(DioClient());

  // // Register CharacterRemoteDataSourceImpl as a singleton
  // getIt.registerSingleton<GoldRemoteDataSourceImpl>(
  //   GoldRemoteDataSourceImpl(dioClient: getIt<DioClient>()),
  // );

  // // Register CharacterRepoImpl as a singleton
  // getIt.registerSingleton<GoldRepo>(
  //   GoldRepoImpl(goldRemoteDataSourceImpl: getIt<GoldRemoteDataSourceImpl>()),
  // );




}