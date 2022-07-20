import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:netflix/domain/core/failures/main_failure.dart';
import 'package:netflix/domain/downloads/i_downloads_repo.dart';
import 'package:netflix/domain/downloads/model/downloads.dart';
import 'package:netflix/domain/search/model/search.dart';
import 'package:netflix/domain/search/search_services.dart';

part 'search_event.dart';
part 'search_state.dart';
part 'search_bloc.freezed.dart';

@injectable
class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final IDownloadsRepo _iDownloadsRepo;
  final SearchServices _searchServices;

  SearchBloc(this._iDownloadsRepo, this._searchServices)
      : super(SearchState.initial()) {
    //idel

    on<Initialized>((event, emit) async {
      if (state.idelList.isNotEmpty) {
        emit(state);
        return;
      }

      emit(const SearchState(
          searchResultList: [], idelList: [], isLoading: true, isError: false));
      //get treding
      final _result = await _iDownloadsRepo.getDownloadsImages();

      // emit( SearchState.initial());

      final statee = _result.fold((MainFailure f) {
        return const SearchState(
          isLoading: false,
          idelList: [],
          isError: true,
          searchResultList: [],
        );
      }, (List<Downloads> list) {
        return SearchState(
          isLoading: false,
          idelList: list,
          isError: false,
          searchResultList: [],
        );
      });
      //show in ui

      emit(statee);
    });

// search result
    on<SearchMovie>((event, emit) async {
      //call search movi api
      emit(const SearchState(
          searchResultList: [], idelList: [], isLoading: true, isError: false));
      //api_call
      final searchResult =
          await _searchServices.searchMovies(movieQuery: event.movieQuery);
      print(searchResult);

      final statee = searchResult.fold((MainFailure f) {
        return const SearchState(
          isLoading: false,
          idelList: [],
          isError: true,
          searchResultList: [],
        );
      }, (Search list) {
        return SearchState(
          isLoading: false,
          idelList: [],
          isError: false,
          searchResultList: list.result ?? [],
        );
      });
      //show in ui

      emit(statee);
      //show in ui
    });
  }
}
