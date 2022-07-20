import 'package:dartz/dartz.dart';
import 'package:netflix/domain/core/failures/main_failure.dart';
import 'package:netflix/domain/downloads/model/downloads.dart';
import 'package:netflix/domain/search/model/search.dart';

abstract class SearchServices {
  Future<Either<MainFailure, Search>> searchMovies({
    required String movieQuery,
  }); 
}