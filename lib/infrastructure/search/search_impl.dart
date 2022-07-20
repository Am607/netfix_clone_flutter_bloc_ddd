import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:netflix/domain/core/api_endpoints.dart';
import 'package:netflix/domain/search/model/search.dart';
import 'package:netflix/domain/core/failures/main_failure.dart';
import 'package:dartz/dartz.dart';
import 'package:netflix/domain/search/search_services.dart';

@LazySingleton(as: SearchServices)
class SearchImpli implements SearchServices {
  @override
  Future<Either<MainFailure, Search>> searchMovies(
      {required String movieQuery}) async {
    try {
      print(1);
      print(movieQuery);
      final response =
          await Dio(BaseOptions()).get(EndPoint.search, queryParameters: {
        'query': movieQuery,

      });
      if (response.statusCode == 200 || response.statusCode == 201) {
        print(response.data);
        final searchResult = Search.fromJson(response.data);
        print(searchResult.result.toString());
        print(2);
        return Right(searchResult);
      } else {
        print(MainFailure.serverFailure().toString());
        return const Left(MainFailure.serverFailure());
      }
    } catch (e) {
      print(3);
      print(e.toString());
      return const Left(MainFailure.clientFailure());
    }
  }
}
