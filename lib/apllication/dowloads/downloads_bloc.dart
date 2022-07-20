import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:netflix/domain/core/failures/main_failure.dart';
import 'package:netflix/domain/downloads/i_downloads_repo.dart';

import '../../domain/downloads/model/downloads.dart';
part 'downloads_bloc.freezed.dart';

part 'downloads_event.dart';
part 'downloads_state.dart';

// mean instead of idownloads ropo we will replace the instance of download repo
@injectable
class DownloadsBloc extends Bloc<DownloadsEvent, DownloadsState> {
  final IDownloadsRepo _downloadsRepo;

  DownloadsBloc(this._downloadsRepo) : super(DownloadsState.initial()) {
    on<_GetDownloadsImage>((event, emit) async {
      emit(state.copyWith(isLoading: true, failureOrSuccessOption: none()));
  
      // api calling
      final Either<MainFailure, List<Downloads>> downloadOption =
          await _downloadsRepo.getDownloadsImages();
      log(downloadOption.toString());

      emit(downloadOption.fold(
          (failure) => state.copyWith(
              isLoading: false, failureOrSuccessOption: Some(Left(failure))),
          (success) => state.copyWith(
              downloads: success,
              isLoading: false,
              failureOrSuccessOption: Some(Right(success)))));
    });
  }
}
